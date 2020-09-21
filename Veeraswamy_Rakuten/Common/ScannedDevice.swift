//
//  ScannedDevice.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreBluetooth
class ScannedDevice {
    
    enum ScannedDeviceType : Int {
        case unknown
        
    }
    enum ScannedDeviceCategory : Int {
        case mobileTerminal
        case wirelessAccessory
    }
    
    var serialNumber: String?
    var peripheral: CBPeripheral?
    var name: String?
    var deviceType: ScannedDeviceType?
    var deviceCategory: ScannedDeviceCategory?

}
