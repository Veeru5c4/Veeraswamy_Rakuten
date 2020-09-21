//
//  Notify.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreBluetooth
class Notify{

    static var reconnectAlert: UIAlertController?
    init() {
        Notify.reconnectAlert = UIAlertController()
    }
    
    class func handle(_ notification: Notification?, viewController vc: UIViewController?) {
        
        if (notification!.name.rawValue == centralManagerDidUpdateStateName()) {
            let centralManager = notification!.object as? CBCentralManager
            if centralManager?.state == .poweredOff {
                vc!.navigationController?.popToRootViewController(animated: true)
            }
        } else if (notification!.name.rawValue == didDisconnectPeripheralName()) && !Singleton.shared.central!.disconnectExpected {
            UIApplication.shared.endIgnoringInteractionEvents()
            let alert = UIAlertController(title: "Device Disconnected", message: "The connection has been closed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                vc!.navigationController?.popToRootViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Reconnect", style: .default, handler: { action in
                
             
                NotificationCenter.default.addObserver(self, selector: #selector(Notify.dismissAlert), name: Notification.Name("reconnected"), object: nil)
                alert.dismiss(animated: true, completion: nil)
                
                
                Notify.reconnectAlert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    Singleton.shared.central!.centralManager!.cancelPeripheralConnection(Singleton.shared.connectedDevice!.peripheral!)
                    vc!.navigationController?.popToRootViewController(animated: true)
                    
                   
                }))
                vc!.present(Notify.reconnectAlert!, animated: true, completion: nil)
            }))
            vc!.present(alert, animated: true)
        }
    }
    
    @objc
    class func dismissAlert() {
        if Notify.reconnectAlert!.isViewLoaded {
            Notify.reconnectAlert?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    class func deviceNewName() -> String? {
        return "DeviceNew"
    }
    
    class func deviceNew() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.deviceNewName()!), object: nil)
    }
    
    class func deviceUpdatedName() -> String? {
        return "DeviceUpdated"
    }
    
    class func deviceUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.deviceUpdatedName()!), object: nil)
    }
    
    class func connectedDeviceUpdatedName() -> String? {
        return "ConnectedDeviceUpdated"
    }
    
    class func connectedDeviceUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.connectedDeviceUpdatedName()!), object: nil)
    }
    
    class func centralManagerDidUpdateStateName() -> String? {
        return "CentralManagerDidUpdateStateName"
    }
    
    class func centralManagerDidUpdateState(_ centralManager: CBCentralManager) {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.centralManagerDidUpdateStateName()!), object: centralManager)
    }
    
    class func didDisconnectPeripheralName() -> String? {
        return "DidDisconnectPeripheral"
    }
    
    class func didDisconnectPeripheral() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.didDisconnectPeripheralName()!), object: nil)
    }
    
    class func satellitesUpdatedName() -> String? {
        return "SatellitesUpdated"
    }
    
    class func satellitesUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.satellitesUpdatedName()!), object: nil)
    }
    
    class func gnssUpdatedName() -> String? {
        return "GNSSUpdated"
    }
    
    class func gnssUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.gnssUpdatedName()!), object: nil)
    }
    
    class func statusUpdatedName() -> String? {
        return "StatusUpdated"
    }
    
    class func statusUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.statusUpdatedName()!), object: nil)
    }
    
    class func configurationUpdatedName() -> String? {
        return "ConfigurationUpdated"
    }
    
    class func configurationUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.configurationUpdatedName()!), object: nil)
    }
    
    class func forwardMessagesUpdatedName() -> String? {
        return "ForwardMessagesUpdated"
    }
    
    class func forwardMessagesUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.forwardMessagesUpdatedName()!), object: nil)
    }
    
    class func returnMessagesUpdatedName() -> String? {
        return "ReturnMessagesUpdated"
    }
    
    class func returnMessagesUpdated() {
        NotificationCenter.default.post(name: Notification.Name.init(Notify.returnMessagesUpdatedName()!), object: nil)
    }
}
