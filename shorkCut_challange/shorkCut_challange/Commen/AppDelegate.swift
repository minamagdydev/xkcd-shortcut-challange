//
//  AppDelegate.swift
//  shorkCut_challange
//
//  Created by Mina on 10/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppCommunicator.shared.initialiseApp()
        return true
    }

}

