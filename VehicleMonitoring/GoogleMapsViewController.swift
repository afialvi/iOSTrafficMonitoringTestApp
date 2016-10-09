//
//  GoogleMapsViewController.swift
//  VehicleMonitoring
//
//  Created by Muhammad Sadiq Alvi on 10/7/16.
//  Copyright © 2016 Muhammad Sadiq Alvi. All rights reserved.
//

import UIKit
import GoogleMaps
import MQTTKit

class GoogleMapsViewController: UIViewController {
    
    var vehiclesData = ["ABC": Vehicle(des: "",heading: "",id: "ABC", laititude: 0.0, longitude: 0.0, speed: 0, type: "car"), "DEF": Vehicle(des: "",heading: "",id: "DEF", laititude: 0.0, longitude: 0.0, speed: 0, type: "car"), "GHI": Vehicle(des: "",heading: "",id: "GHI", laititude: 0.0, longitude: 0.0, speed: 0, type: "car")]
    var camera:GMSCameraPosition?
    var count = 0
    var mapView: GMSMapView?
    let numOfCallbacksBeforeMapUpdate = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToIoT()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        self.camera = GMSCameraPosition.cameraWithLatitude(0.0, longitude: 0.0, zoom: 10.0)
        self.mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: self.camera!)
        self.mapView!.myLocationEnabled = true
        self.view = self.mapView!
    }
    
    func subscribeToIoT(){
        let subscriptionStr = "iot-2/type/vehicle/id/+/evt/telemetry/fmt/json"
        
        AppDelegate.client?.messageHandler = { mqttmsg in
            let respDict: NSDictionary? = try?NSJSONSerialization.JSONObjectWithData(mqttmsg.payload!,
                                                                                     options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            if(respDict != nil)
            {
                print(self.count)
                let currVehicle = self.vehiclesData[respDict!["id"] as! String]
                currVehicle?.desc = respDict!["description"] as! String
                currVehicle?.lat = Double(respDict!["lat"] as! String)
                currVehicle?.long = Double(respDict!["lng"] as! String)
                currVehicle?.speed = respDict!["speed"] as! Int
                currVehicle?.marker?.position = CLLocationCoordinate2D(latitude: (currVehicle?.lat)!, longitude: (currVehicle?.long)!)
                currVehicle?.updateSnippet()
                if(self.count == self.numOfCallbacksBeforeMapUpdate){
                    dispatch_async(dispatch_get_main_queue(),{
                    self.camera = GMSCameraPosition.cameraWithLatitude((currVehicle?.lat)!, longitude: (currVehicle?.long)!, zoom: 10.0)
                    self.mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: self.camera!)
                    self.mapView!.myLocationEnabled = true
                    self.view = self.mapView
                    })
                }
                self.count = self.count + 1
                if(self.count % self.numOfCallbacksBeforeMapUpdate == 0){
                    print("Calling Update Map")
                    self.updateMap()
                }
                

            }
        }
        AppDelegate.client?.subscribe(subscriptionStr, withQos: AtLeastOnce, completionHandler: { (thismsg) in
            print(thismsg)
            for obj in thismsg {
                print(obj)
            }
            
        })
    }
    func updateMap(){
        dispatch_async(dispatch_get_main_queue(),{

            for (id, currVehicle) in self.vehiclesData{
            currVehicle.marker?.title = id
            currVehicle.marker?.map = self.mapView!
            
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
