//
//  AppDelegate.swift
//  VehicleMonitoring
//
//  Created by Muhammad Sadiq Alvi on 10/1/16.
//  Copyright © 2016 Muhammad Sadiq Alvi. All rights reserved.
//

import UIKit
import BMSCore
import BMSSecurity
import GoogleMaps
import GoogleMapsCore
import MQTTKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let backendURL = "https://alvi-app.mybluemix.net/"
    let backendGUID = "37f8eebf-7879-4f8f-a1ad-d1874f432d71"
    let tenantId = "37f8eebf-7879-4f8f-a1ad-d1874f432d71"
    static var client: MQTTClient?
//    let backendGUID = "5e95097d-ad76-4712-9ba7-f741e716e107"
//    let tenantId = "5e95097d-ad76-4712-9ba7-f741e716e107"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainViewController:MainViewController = MainViewController()
        let navController: UINavigationController = UINavigationController(rootViewController: mainViewController)
    
        
        
        self.window?.rootViewController = navController;//making a view to root view
        self.window?.makeKeyAndVisible();

        BMSClient.sharedInstance.initialize(bluemixAppRoute: backendURL, bluemixAppGUID: backendGUID, bluemixRegion: BMSClient.Region.usSouth)
        
        let mcaAuthManager = MCAAuthorizationManager.sharedInstance
        mcaAuthManager.initialize(tenantId: tenantId)
        BMSClient.sharedInstance.authorizationManager = mcaAuthManager
        BMSClient.sharedInstance.authorizationManager = MCAAuthorizationManager.sharedInstance
        
        GMSServices.provideAPIKey("AIzaSyAnSjuj4yt3ABQXg1o4t2tFPMv_e5HwZlA")
        
        connectToIoT()
       
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func connectToIoT(){
        //        self.loadingView?.hidden = false
        let msgingurl = "yap355.messaging.internetofthings.ibmcloud.com"
        let cid = "a:yap355:myios"
        //                let client: MQTTClient = MQTTClient(clientId: "37f8eebf-7879-4f8f-a1ad-d1874f432d71")
        AppDelegate.client = MQTTClient(clientId: cid)
        AppDelegate.client!.username = "a-yap355-rfxqfekzd8"
        AppDelegate.client!.password = "JLumfw?Y8AAr7aX!7z"
        AppDelegate.client!.port = 1883
        
        AppDelegate.client!.connectToHost(msgingurl) { (MQTTConnectionReturnCode) in
            if(MQTTConnectionReturnCode == ConnectionAccepted){
                
                print("Connection Accepted")
                
            }
            else{
                
                print("Connection Not Accepted: \(MQTTConnectionReturnCode)")
                
            }
        }
    }
    
}

