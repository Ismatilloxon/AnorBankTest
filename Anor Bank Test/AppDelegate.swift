//
//  AppDelegate.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marufkhonov on 29/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // For increasing launch screen time
        Thread.sleep(forTimeInterval: 2.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}
