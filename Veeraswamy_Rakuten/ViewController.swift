//
//  ViewController.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func connectDevicebtnClicked(_ sender: Any) {
        
        [self.performSegue(withIdentifier:"connect", sender: nil)];
    }
    @IBAction func connectHistortbtnClicked(_ sender: Any) {
        [self.performSegue(withIdentifier:"history", sender:nil)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

