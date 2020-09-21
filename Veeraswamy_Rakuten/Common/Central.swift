//
//  Central.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreBluetooth

class Central: NSObject,CBCentralManagerDelegate {
    var centralManager: CBCentralManager?
    var scannedDeviceList = ScannedDeviceList()
    var disconnectExpected = false
    
    var scanState: ScanState?
    var connectState: ConnectState?
    var hostScan = false
   // var pendingConnectDeviceType: ScannedDevice.ScannedDeviceType?
    
    enum ScanState : Int {
        case none
        case pending
        case active
    }
    
    enum ConnectState : Int {
        case none
        case pending
        case active
    }
    override init() {
        super.init()
        scannedDeviceList = ScannedDeviceList()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("CoreBluetooth central manager state: \(central.state.rawValue)")
        startScan()
        Notify.centralManagerDidUpdateState(centralManager!)
    }
    
   
    func startScanForHost() {
        if scanState != ScanState.active {
            hostScan = true
            scanState = ScanState.pending
            startScan()
        }
    }
    
    func startScanForAccessory() {
        if scanState != ScanState.active {
            hostScan = false
            scanState = ScanState.pending
            startScan()
        }
    }
    
    func startScan() {
        if centralManager == nil {
            print("Bluetooth initializing")
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
        if scanState == ScanState.pending && centralManager!.state == .poweredOn {
            print("Bluetooth scan starting")
            centralManager!.delegate = self
            scanState = ScanState.active
            centralManager!.scanForPeripherals(withServices: nil, options: [
                CBCentralManagerScanOptionAllowDuplicatesKey: NSNumber(value: true)
                ])
        }
    }
    
    func close() {
        stopScan()
        disconnectDevice()
        centralManager = nil
    }
    
    func disconnectDevice() {
        if Singleton.shared.connectedDevice != nil {
            disconnectExpected = true
            Singleton.shared.connectedDevice!.disconnect(from: centralManager)
            Singleton.shared.connectedDevice = nil
        }
        connectState = ConnectState.none
    }
    
    func stopScan() {
        if scanState == ScanState.active {
            print("Bluetooth scan stopping")
            centralManager!.stopScan()
        }
        scanState = ScanState.none
    }
    
    // CBCentralManagerDelegates
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
       let serialNumber:String? = peripheral.name ?? ""
       print("New peripheral: \(String(describing: serialNumber!)) (\(peripheral.identifier.uuidString))")
        
       var verifiedDevice = false
        for deviceRegex in AppDelegate.regex.list {
            if deviceRegex.isRegexVerifiedWith(serNumber:serialNumber ?? "") {
                verifiedDevice = true
            }
        }
        
        let scannedDevice: ScannedDevice? = scannedDeviceList.scannedDevice(withSerialNumber: serialNumber)
        if (scannedDevice != nil) {
            if (RSSI.intValue != 127) {
               }
            return;
        }
        
        let device = ScannedDevice()
        device.peripheral = peripheral
        var nameExists = false
        for deviceRegex in AppDelegate.regex.list {
            if deviceRegex.isRegexVerifiedWith(serNumber: serialNumber!) {
                nameExists = true
                device.deviceType = deviceRegex.scannedRegexDeviceType
            }
        }
        if !nameExists {
            device.deviceType = ScannedDevice.ScannedDeviceType.unknown
        }
        device.serialNumber = serialNumber!
         var exist = false
        for scannedDevice in scannedDeviceList.theScannedDeviceList {
            if scannedDevice.serialNumber!.contains(serialNumber!) {
                exist = true
            }
        }
        if !exist {
            Singleton.shared.central!.scannedDeviceList.newScannedDevice(device)
        }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
       print("didConnectPeripheral: \(peripheral.identifier.uuidString)")
      var connectedDevice: ConnectedDevice? = nil
      connectedDevice = DeviceInfo()
       if connectedDevice != nil {
            Singleton.shared.connectedDevice = connectedDevice
            connectState = ConnectState.active
            Singleton.shared.connectedDevice!.connect(peripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        connectState = ConnectState.none
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectState = ConnectState.none
       }
    
    
}

    

    



