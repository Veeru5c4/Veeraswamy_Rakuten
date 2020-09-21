//
//  Singleton.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreBluetooth
class Singleton {

    static var shared = Singleton()
    static var initialized = false
    var central: Central!
    var history: History!
    var connectedDevice: ConnectedDevice?
    init() {
        if !Singleton.initialized {
            Singleton.initialized = true
            central = Central()
            history = History()
        }
    }
}
