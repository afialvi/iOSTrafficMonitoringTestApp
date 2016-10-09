//
//  Vehicle.swift
//  VehicleMonitoring
//
//  Created by Muhammad Sadiq Alvi on 10/9/16.
//  Copyright © 2016 Muhammad Sadiq Alvi. All rights reserved.
//

import UIKit
import GoogleMaps

class Vehicle: NSObject {
    var desc: String?
    var heading: String?
    var id: String?
    var lat: Double?
    var long: Double?
    var speed: Int?
    var type: String?
    var marker: GMSMarker?
    init(des: String, heading: String, id:String, laititude: Double, longitude:Double, speed: Int, type: String ) {
        self.desc = des
        self.heading = heading
        self.id = id
        self.lat = laititude
        self.long = longitude
        self.speed = speed
        self.type = type
        self.marker = GMSMarker()
        self.marker!.position = CLLocationCoordinate2D(latitude: self.lat!, longitude: self.long!)
        self.marker!.icon = UIImage(named: "redcar")
        self.marker?.snippet = "Speed : \(self.speed!)\nLocation : \(self.lat),\(self.long!)"
    }
    func updateSnippet(){
        dispatch_async(dispatch_get_main_queue(),{
        self.marker?.snippet = "Speed : \(self.speed!)\nLocation : \(self.lat!),\(self.long!)"
        })
    }
}
