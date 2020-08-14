//
//  AppDelegate.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TemperatureListViewController())
        AppAppearance.setupAppearance()
        return true
    }
}
