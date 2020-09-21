//
//  ConnectedDevice.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreBluetooth
class ConnectedDevice: NSObject,NSCoding {
    var connectDate: Date?
    var peripheral: CBPeripheral?
    var type: String {
        get {
            return self.isType()
        }
    }
    var connectedBool = false
    
    override init() {
        super.init()
        connectDate = Date()
    }
    
    required init?(coder: NSCoder) {
        connectDate = coder.decodeObject(forKey: "connectDate") as? Date
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(connectDate, forKey: "connectDate")
    }
    
    func theIdentifier() -> String {
        return ""
    }
    
    func isType() -> String {
        return ""
    }
    
   func startDemo(withSerialNumber serialNumber: String) {
        
    }
    
    func disconnect(from centralManager: CBCentralManager?) {
        
    }
    
    func connect(_ peripheral: CBPeripheral?) {
        
    }

}
