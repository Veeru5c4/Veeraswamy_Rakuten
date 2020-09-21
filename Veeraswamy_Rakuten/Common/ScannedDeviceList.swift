//
//  ScannedDeviceList.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import Foundation
class ScannedDeviceList {
    
    var devices: [ScannedDevice] {
        get {
            return theScannedDeviceList
        }
        set {
        }
    }
    
    var scannedDeviceList: [ScannedDevice] = []
    var theScannedDeviceList: [ScannedDevice] = []
    
    init() {
        scannedDeviceList = [ScannedDevice]()
        theScannedDeviceList = [ScannedDevice]()
    }
    
    func newDevices() -> [ScannedDevice]? {
        return theScannedDeviceList
    }
    
    func newScannedDevice(_ scannedDevice: ScannedDevice?) {
        if let scannedDevice = scannedDevice {
            theScannedDeviceList.append(scannedDevice)
        }
    }
    
    func scannedDevice(withSerialNumber serialNumber: String?) -> ScannedDevice? {
        for index in 0..<theScannedDeviceList.count {
            let device: ScannedDevice = theScannedDeviceList[index]
            if (device.serialNumber == serialNumber) {
                return device
            }
        }
        return nil
    }
    
    func copyDevices() -> [ScannedDevice]? {
        var deviceList: [ScannedDevice] = []
        for device in theScannedDeviceList {
            deviceList.append(device)
        }
        return deviceList
    }
    
    
   
    
  
    
}
