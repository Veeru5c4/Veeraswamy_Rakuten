//
//  DeviceInfo.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreBluetooth
class DeviceInfo: ConnectedDevice, CBPeripheralDelegate  {
    
    var deviceDescriptorServiceUUID = CBUUID(string: "29820000-6BA6-11E6-8B77-86F30CA893D3")
    var deviceDescriptorLabelCharacteristicUUID = CBUUID(string: "29820001-6BA6-11E6-8B77-86F30CA893D3")
    var deviceDescriptorDeviceNumberCharacteristicUUID = CBUUID(string: "29820006-6BA6-11E6-8B77-86F30CA893D3")
    var deviceDescriptorModelNumberCharacteristicUUID = CBUUID(string: "2A24")
    var deviceDescriptorSerialNumberCharacteristicUUID = CBUUID(string: "2A25")
    var deviceDescriptorFirmwareVersionCharacteristicUUID = CBUUID(string: "2A26")
    var deviceDescriptorHardwareVersionCharacteristicUUID = CBUUID(string: "2A27")
    
    lazy var deviceDescriptorCharacteristicUUIDs = [
        deviceDescriptorLabelCharacteristicUUID,
        deviceDescriptorDeviceNumberCharacteristicUUID,
        deviceDescriptorModelNumberCharacteristicUUID,
        deviceDescriptorSerialNumberCharacteristicUUID,
        deviceDescriptorFirmwareVersionCharacteristicUUID,
        deviceDescriptorHardwareVersionCharacteristicUUID
    ]
    
    lazy var readValueCharacteristicUUIDs = [
        deviceDescriptorDeviceNumberCharacteristicUUID,
        deviceDescriptorModelNumberCharacteristicUUID,
        deviceDescriptorSerialNumberCharacteristicUUID,
        deviceDescriptorFirmwareVersionCharacteristicUUID,
        deviceDescriptorHardwareVersionCharacteristicUUID
    ]
    override func connect(_ peripheral: CBPeripheral?) {
        print("Connecting door sensor peripheral")
        self.peripheral = peripheral
        self.peripheral!.delegate = self
    self.peripheral!.discoverServices(deviceDescriptorCharacteristicUUIDs)
    }
    override func disconnect(from centralManager: CBCentralManager?) {
        if peripheral != nil {
            print("Disconnecting peripheral")
            centralManager?.cancelPeripheralConnection(peripheral!)
        }
    }
    
    func peripheral(_ myPeripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            print("didDiscoverServices error:\(String(describing: error))")
        }
        let services = peripheral?.services
        for service in services! {
           
            if service.uuid.isEqual(deviceDescriptorServiceUUID) {
                peripheral!.discoverCharacteristics(deviceDescriptorCharacteristicUUIDs, for: service)
            }
        }
    }
    
    func peripheral(_ myPeripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil {
            print("didDiscoverCharacteristicsForService error: \(String(describing: error))")
        }
        for characteristic in service.characteristics ?? [] {
           
            if isCharacteristic(characteristic, inUUIDs: readValueCharacteristicUUIDs) {
                peripheral!.readValue(for: characteristic)
            }
           
        }
    }
    
    func isCharacteristic(_ characteristic: CBCharacteristic?, inUUIDs uuids: [CBUUID]?) -> Bool {
        for uuid in uuids ?? [] {
            if uuid.isEqual(characteristic?.uuid) {
                return true
            }
        }
        return false
    }

}
