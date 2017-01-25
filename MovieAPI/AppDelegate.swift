//
//  AppDelegate.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let newt = Alamofire.NetworkReachabilityManager(host: "https://www.themoviedb.org/")

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        self.newt?.listener = { status in
            print("Network Status Changed: \(status)")
            switch status {
            case .notReachable: break
            //Show error state
            case .reachable(_), .unknown: break
                //Hide error state
            }
        }
        
        self.newt?.startListening()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

