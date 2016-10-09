//
//  MainViewController.swift
//  VehicleMonitoring
//
//  Created by Muhammad Sadiq Alvi on 10/2/16.
//  Copyright © 2016 Muhammad Sadiq Alvi. All rights reserved.
//

import UIKit
import BMSCore
import BMSSecurity
//import MQTT
import MQTTKit
//import MQTTClient



class MainViewController: UIViewController {

    @IBOutlet weak var msgId: UITextField!
    
    @IBOutlet weak var msg: UITextField!
    
    @IBOutlet weak var propertyId: UITextField!
    
    @IBOutlet weak var property: UITextField!
    
    @IBOutlet weak var propertyValue: UITextField!
    
    @IBOutlet weak var currentStatus: UILabel!
    
    let mapURL = "http://alvi-app.mybluemix.net/"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
//        connectToIoT()
    }
    func handleTap(){
        self.msgId.endEditing(true)
        self.msg.endEditing(true)
        self.propertyId.endEditing(true)
        self.property.endEditing(true)
        self.propertyValue.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
        


    
    
    @IBAction func sendMessage(sender: AnyObject) {
        let vehicleId = msgId.text!
        let message = msg.text!
        let msgString = "{\"id\":\"\(vehicleId)\",\"text\":\"\(message)\", \"duration\":5000 }"
        AppDelegate.client!.publishString(msgString, toTopic: "iot-2/type/api/id/tester/cmd/addOverlay/fmt/json", withQos: ExactlyOnce, retain: false, completionHandler: { (code) in
            print(code)
        })
    }
    
    
    
    @IBAction func updateProperty(sender: AnyObject) {
        
        let vehicleId = propertyId.text!
        let value = propertyValue.text!
        print(vehicleId)
        print(value)
        AppDelegate.client!.publishString("{\"id\":\"\(vehicleId)\",\"property\":\"speed\", \"value\":"+value+" }", toTopic: "iot-2/type/vehicle/id/\(vehicleId)/cmd/setProperty/fmt/json", withQos: ExactlyOnce, retain: false, completionHandler: { (code) in
            print(code)
        })
        
}

    
  


    @IBAction func viewTrafficMap(sender: AnyObject) {
//        let mapViewController: MapViewController = MapViewController()
//        self.navigationController?.pushViewController(mapViewController, animated: true)
        let googleMapsViewController: GoogleMapsViewController = GoogleMapsViewController()
        self.navigationController?.pushViewController(googleMapsViewController, animated: true)
    }
    
}
