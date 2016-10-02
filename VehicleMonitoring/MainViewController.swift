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
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
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
    }
    
    
    
    @IBAction func updateProperty(sender: AnyObject) {
        
        let str = "iot-2/type/vehicle/id/ABC/cmd/setProperty/fmt/json"
        let customResourceURL = "http://alvi-app.mybluemix.net/protected/?destinationName="+str
        //                print(customResourceURL)
        //                let request = Request(url: customResourceURL, method: HttpMethod.GET)
        
        //        let dict:NSDictionary = ["id": "ABC", "property":"Speed", "value":"90"]
        //        let str = "{\"destinationName\":\"iot-2//type//vehicle//id//ABC//cmd//setProperty//fmt//json\", \"id\":\"ABC\", \"property\":\"Speed\", \"value\":\"90\"}"
        
        //        let dict:NSDictionary = ["message": str]
        
        //        let restUrl = "http://yap355.messaging.internetofthings.ibmcloud.com:1883/api/v0002/mgmt/requests/"
        
        let restUrl2 = "http://yap355.messaging.internetofthings.ibmcloud.com:1883/api/v0002/device/types/vehicle/devices/ABC/events/setProperty/"
        
        let jsonStr = "{\"payload\": {\"id\":\"ABC\",\"property\":\"Speed\",\"value\":\"90\"}}"
        var dic = ["id":"ABC","property":"Speed", "value":"60"]
        
        
        let dta: NSData = NSKeyedArchiver.archivedDataWithRootObject(jsonStr)
        //        let dta: NSData = NSKeyedArchiver.archivedDataWithRootObject(str)
        //        dict = ["id": propertyId.text!, "property":property.text!, "value":propertyValue.text!]
        //        var data: NSData = NSData
        let logger = Logger.logger(name: "My Logger")
        //        Logger.set
        let urlSession = BMSURLSession(configuration: .defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: restUrl2)!)
        //        request.HTTPMethod = "POST"
        
        request.allHTTPHeaderFields = ["Authorization":"a-yap355-rfxqfekzd8:{\"token\":\"JLumfw?Y8AAr7aX!7z\"}", "content-type":"application/json"]
        //        request.HTTPBody = dta
        //
        //
        
        let dataTask = urlSession.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let httpResponse = response as? NSHTTPURLResponse {
                //                logger.info(message: "Status code: \(httpResponse.statusCode)")
                print(httpResponse)
            }
            if data != nil, let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                logger.info(message: "Response data: \(responseString)")
            }
            if let error = error {
                logger.error(message: "Error: \(error)")
            }
        }
        
        dataTask.resume()
        
        //        let msgingurl = "yap355.messaging.internetofthings.ibmcloud.com:1883"
        //        let client: MQTTClient = MQTTClient(clientId: "37f8eebf-7879-4f8f-a1ad-d1874f432d71")
        //        client.username = "a-yap355-rfxqfekzd8"
        //        client.password = "JLumfw?Y8AAr7aX!7z"
        ////        client.port = 1883
        //        client.connectToHost(msgingurl) { (MQTTConnectionReturnCode) in
        //            if(MQTTConnectionReturnCode == ConnectionAccepted){
        //                print("Connection Accepted")
        ////                var msg: MQTTMessage = MQTTMessage()
        ////                msg.payloadString()
        ////                msg.topic = str
        //
        //            }
        //            else{
        //                print("Connection Not Accepted: \(MQTTConnectionReturnCode)")
        //            }
        //        }
        
        
        
        //                let callBack:BMSCompletionHandler = {(response: Response?, error: NSError?) in
        //                    if error == nil {
        //                        print ("response:\(response?.responseText), no error")
        //                    } else {
        //                        print ("error: \(error)")
        //                    }
        //                }
        //
        ////                request.send(requestBody:dta, completionHandler: callBack)
        //         request.send(completionHandler: callBack)
        
        
    }
    
    
  


    @IBAction func viewTrafficMap(sender: AnyObject) {
        let mapViewController: MapViewController = MapViewController()
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }

}
