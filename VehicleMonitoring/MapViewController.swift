//
//  MapViewController.swift
//  VehicleMonitoring
//
//  Created by Muhammad Sadiq Alvi on 10/2/16.
//  Copyright © 2016 Muhammad Sadiq Alvi. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIWebViewDelegate{

    @IBOutlet weak var mapWebView: UIWebView!
    
    var loadingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapUrl = "http://alvi-app.mybluemix.net/"
//        addLoadingView()
        self.mapWebView.loadRequest(NSURLRequest(URL: NSURL(string: mapUrl)!))
        self.mapWebView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
