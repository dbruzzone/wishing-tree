//
//  BluetoothManager.swift
//  Control
//
//  Created by Davide Bruzzone on 12/4/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import Foundation

import CoreBluetooth

// The protocol that informs delegates when BluetoothManager lifecycle events occur
protocol BluetoothManagerDelegate {
    func hardwareReady()
    func peripheralDiscovered()
}

// The protocol that informs delegates when Bluetooth peripherals are selected
protocol PeripheralSelectionDelegate {
    func peripheralSelected(peripheral: CBPeripheral)
}

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    // The class' singleton instance
    static let sharedInstance = BluetoothManager()

    var delegate: BluetoothManagerDelegate?

    var centralManager: CBCentralManager?
    
    var discoveredPeripherals: [CBPeripheral] = []
    
    // The flag that indicates whether the central manager has been initialized - This only
    // happens once when the BluetoothManager singleton is instantiated - and the Bluetooth
    // hardware is ready
    var hardwareReady: Bool = false
    var scanning: Bool = false

    override init () {
        super.init()

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

    // MARK: - CBCentralManagerDelegate

    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case CBCentralManagerState.PoweredOff:
            print("The Bluetooth hardware is powered off")
        case CBCentralManagerState.PoweredOn:
            print("The Bluetooth hardware is ready")

            hardwareReady = true
            
            delegate!.hardwareReady()
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
            
            delegate!.peripheralDiscovered()
            
            // TODO
            // Try to connect to peripheral
            //centralManager?.connectPeripheral(peripheral, options: nil)
        }
    }
    
    // TODO
    /*
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Connected to the \(peripheral.name) peripheral")
    
        peripheral.delegate = self
    
        peripheral.discoverServices(nil)
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        for service: CBService in peripheral.services! {
            print("Discovered a service:\n- UUID: \(service.UUID)\n- Service: \(service)")
        }
    }
    */

}
