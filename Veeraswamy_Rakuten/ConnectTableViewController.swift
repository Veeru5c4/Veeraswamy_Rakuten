//
//  ConnectTableViewController.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit

class ConnectTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   @IBOutlet weak var tableView: UITableView!
   var spinner = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.size.width * 0.5) - 30, y: (UIScreen.main.bounds.size.height * 0.5) - 95, width: 55, height: 55))
    var updateDeviceListTimer = Timer()
    var scannedList = ScannedDeviceList()
    var updating = false
    var label: UILabel?
    var connectingDevice: ScannedDevice?
    var count: Int = 0
    var alertController: UIAlertController?
    var cancelAction: UIAlertAction?
    
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count = 0
        updating = false
        UIApplication.shared.isIdleTimerDisabled = true
        startScan()
        tableView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // hide search to prevent problems when popping back to this view controller
        
        if spinner.isAnimating {
            spinner.stopAnimating()
        }
        if let newAlertController = alertController {
            if (newAlertController.isViewLoaded) {
                newAlertController.dismiss(animated: false, completion: nil)
            }
        }
        if label != nil {
            label!.removeFromSuperview()
        }
        super.viewWillDisappear(animated)
        updateDeviceListTimer.invalidate()
    }
    
    
  // MARK: Start Scanning
    
    func startScan() {
        initializeLoadingDialog()
        Singleton.shared.central!.close()
        Singleton.shared.central!.startScanForHost()
    }
    
   // MARK: loader
    
    func initializeLoadingDialog() {
        updateDeviceListTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.displayDevices), userInfo: nil, repeats: true)
        spinner.layer.cornerRadius = 10.0
        spinner.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        spinner.backgroundColor = UIColor(white: 0.80, alpha: 0.9)
        spinner.color = UIColor.black
        view.addSubview(spinner)
        view.window?.addSubview(spinner)
        spinner.startAnimating()
        label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.size.width * 0.5) - 40, y: (UIScreen.main.bounds.size.height * 0.5) - 35, width: 75, height: 25))
        label!.text = ""
        label!.numberOfLines = 1
        label!.baselineAdjustment = .alignBaselines // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        label!.adjustsFontSizeToFitWidth = true
        label!.backgroundColor = UIColor.clear
        label!.textColor = UIColor.black
        label!.textAlignment = .center
        label!.font = UIFont.systemFont(ofSize: 22.0)
        view.addSubview(label!)
        view.window?.addSubview(label!)
    }
    
    @objc func displayDevices() {
        if Singleton.shared.central!.scannedDeviceList.theScannedDeviceList.count > 0 {
            updating = true
          
            view.isUserInteractionEnabled = true
            if spinner.isAnimating {
                spinner.stopAnimating()
            }
            label!.removeFromSuperview()
            tableView.reloadData()
            let delayInSeconds: Double = 0.75
            let popTime = DispatchTime.now() + delayInSeconds
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                self.updating = false
            })
        }
        
        else{
            if spinner.isAnimating {
                spinner.stopAnimating()
            }
            showToast(self, message: "No Devices Found", seconds: 2.0)
        }
    }
    
    
    func showToast(_ controller: UIViewController?, message: String?, seconds: Double) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.view.backgroundColor = UIColor(white: 0.80, alpha: 0.9)
        alert.view.layer.cornerRadius = 10
        present(alert, animated: true)
        let popTime = DispatchTime.now() + seconds
        DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
            alert.dismiss(animated: true)
        })
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Singleton.shared.central!.scannedDeviceList.theScannedDeviceList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectTableViewCell", for: indexPath) as! ConnectTableViewCell
       var device: ScannedDevice?
        device = Singleton.shared.central!.scannedDeviceList.theScannedDeviceList[Int(indexPath.row)]
        cell.serialNumberLabel.text = device!.serialNumber
        cell.nameLabel.text = device!.name
       
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
