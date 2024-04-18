//
//  AppDelegate.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: SignViewController())
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
        return true
    }

   


}

