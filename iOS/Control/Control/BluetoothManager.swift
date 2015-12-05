//
//  BluetoothManager.swift
//  Control
//
//  Created by Davide Bruzzone on 12/4/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import Foundation

import CoreBluetooth

protocol BluetoothManagerProtocol {
    func hardwareReady()
    func peripheralAdded()
}

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    // The class' singleton instance 
    static let sharedInstance = BluetoothManager()

    var delegate: BluetoothManagerProtocol?

    var centralManager: CBCentralManager?
    
    var peripherals: [CBPeripheral] = []
    
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
            print("The device's Bluetooth hardware is powered off")
        case CBCentralManagerState.PoweredOn:
            print("The device's Bluetooth hardware is powered on and ready")
            
            delegate?.hardwareReady()
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
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            
            delegate?.peripheralAdded()
            
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
