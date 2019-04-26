//
//  AppDelegate.swift
//  Off-Places
//
//  Created by Esraa on 4/26/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchScreen()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func isAppFirstLaunch() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: "isAppFirstLaunch") {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "isAppFirstLaunch")
            return true
        }
    }
    
    func launchScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = isAppFirstLaunch() ?
            UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "MapView") as! MapView)
            : UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SavedLocationsView") as! SavedLocationsView)
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
