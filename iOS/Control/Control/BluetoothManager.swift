//
//  BluetoothManager.swift
//  Control
//
//  Created by Davide Bruzzone on 12/4/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import Foundation

import CoreBluetooth

// TODO
// The protocol that informs delegates when BluetoothManager-related events occur
protocol BluetoothManagerDelegate {
    func hardwareReady()
    func peripheralDiscovered()
}

// The protocol that informs delegates when peripheral-related events occur
protocol PeripheralDelegate {
    func peripheralSelected(peripheral: CBPeripheral)
}

// The protocol that informs serviceDelegate when peripheral service-related events occur
protocol PeripheralServiceDelegate {
    func servicesDiscovered(services: [CBService])
}

// The protocol that informs characteristicDelegate when service characteristic-related events occur
protocol ServiceCharacteristicDelegate {
    func characteristicsDiscovered(characteristics: [CBCharacteristic])
}

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    // The class' singleton instance
    static let sharedInstance = BluetoothManager()

    // TODO
    var peripheralDelegate: BluetoothManagerDelegate?
    var serviceDelegate: PeripheralServiceDelegate?
    var characteristicDelegate: ServiceCharacteristicDelegate?

    var centralManager: CBCentralManager?
    
    var discoveredPeripherals: [CBPeripheral] = []
    
    // The flag that indicates whether the central manager has been initialized - This only
    // happens once when the BluetoothManager singleton is instantiated - and the Bluetooth
    // hardware is ready
    var hardwareReady: Bool = false
    var scanning: Bool = false

    override init () {
        super.init()
    }

    func start() {
        centralManager = CBCentralManager.init(delegate: self, queue: nil, options: nil)
    }

    func scan() {
        centralManager!.scanForPeripheralsWithServices(nil, options: nil)

        scanning = true
    }

    func stopScanning() {
        centralManager!.stopScan()

        scanning = false
    }

    func connectToPeripheral(peripheral: CBPeripheral) {
        centralManager!.connectPeripheral(peripheral, options: nil)
    }

    func discoverCharacteristics(peripheral: CBPeripheral, service: CBService) {
        peripheral.discoverCharacteristics(nil, forService: service)
    }

    // MARK: - CBCentralManagerDelegate

    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case CBCentralManagerState.PoweredOff:
            print("The Bluetooth hardware is powered off")
        case CBCentralManagerState.PoweredOn:
            print("The Bluetooth hardware is ready")

            hardwareReady = true
            
            peripheralDelegate!.hardwareReady()
        case CBCentralManagerState.Resetting:
            print("The Bluetooth hardware is resetting")
        case CBCentralManagerState.Unauthorized:
            print("The Bluetooth hardware's state is unauthorized")
        case CBCentralManagerState.Unknown:
            print("The Bluetooth hardware's state is unknown")
        case CBCentralManagerState.Unsupported:
            print("The device doesn't have Bluetooth hardware")
        }
    }

    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        if !(discoveredPeripherals.contains(peripheral)) {
            discoveredPeripherals.append(peripheral)

            peripheralDelegate!.peripheralDiscovered()
        }
    }

    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.delegate = self

        peripheral.discoverServices(nil)
    }

    // MARK: - CBPeripheralDelegate

    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        serviceDelegate!.servicesDiscovered(peripheral.services!)
    }

    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        characteristicDelegate!.characteristicsDiscovered(service.characteristics!)

        // TODO
        for characteristic: CBCharacteristic in service.characteristics! {
            print("- Characteristic:\n\t- UUID: \(characteristic.UUID)\n\t- Description: \(characteristic.description)\n\t- Value: \(characteristic.value)")
        }
    }

}
