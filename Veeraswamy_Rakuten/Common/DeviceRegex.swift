//
//  DeviceRegex.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit

class DeviceRegex {
    
    var expression: NSRegularExpression!
    var scannedRegexDeviceType: ScannedDevice.ScannedDeviceType?
    
    init(regexString: String, type: ScannedDevice.ScannedDeviceType) {
        try! expression = NSRegularExpression(pattern: regexString, options: [])
        scannedRegexDeviceType = type
    }
    
    public func isRegexVerifiedWith(serNumber: String) -> Bool {
        return isMatch(serNumber, forRegex: expression)
    }
    
    public func isMatch(_ text: String?, forRegex regexp: NSRegularExpression?) -> Bool {
        if text == nil {
            return false
        }
        return regexp?.numberOfMatches(in: text ?? "", options: [], range: NSRange(location: 0, length: text?.count ?? 0)) == 1
    }


}
