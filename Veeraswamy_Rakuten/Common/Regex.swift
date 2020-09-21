//
//  Regex.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit

class Regex {

    var serialNumberCharactersRegex: NSRegularExpression!
    var list: [DeviceRegex]!
    init() {
        try! serialNumberCharactersRegex = NSRegularExpression(pattern: "^[a-zA-Z0-9]*$", options: [])
    }
    func isSerialNumberCharacters(_ string: String?) -> Bool {
        return isMatch(string, forRegex: serialNumberCharactersRegex)
    }
    
    func isMatch(_ text: String?, forRegex regexp: NSRegularExpression?) -> Bool {
        if text == nil {
            return false
        }
        return regexp?.numberOfMatches(in: text ?? "", options: [], range: NSRange(location: 0, length: text?.count ?? 0)) == 1
    }
}
