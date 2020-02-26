//
//  AppDelegate.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 02/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    
    func restartApplication() {
        guard let player =  UIApplication.shared.windows[0].rootViewController as? ViewController else {
            return
        }
        player.resetController()
        }
    


}

