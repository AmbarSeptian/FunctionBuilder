//
//  AppDelegate.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 14/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = TextureBuildView2Controller()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
