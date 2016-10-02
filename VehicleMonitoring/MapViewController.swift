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
        addLoadingView()
        self.mapWebView.loadRequest(NSURLRequest(URL: NSURL(string: mapUrl)!))
        self.mapWebView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addLoadingView(){
        loadingView = UIView(frame: CGRectMake(120, 200, 80, 80))
        loadingView!.backgroundColor = UIColor.blackColor()
        loadingView!.layer.cornerRadius = 5;
        
        
        let activityView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        
        activityView.center = CGPointMake(loadingView!.frame.size.width / 2.0, 35);
        activityView.startAnimating()
        loadingView!.addSubview(activityView)
        let lblLoading = UILabel(frame: CGRectMake(0, 48, 80, 30))
        lblLoading.text = "Loading..."
        lblLoading.textColor = UIColor.whiteColor()
        lblLoading.textAlignment = NSTextAlignment.Center
        loadingView!.addSubview(lblLoading)
        self.view.addSubview(loadingView!)
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.loadingView?.hidden = true
    }
    func webViewDidStartLoad(webView: UIWebView) {
        self.loadingView?.hidden = false
    }

}
