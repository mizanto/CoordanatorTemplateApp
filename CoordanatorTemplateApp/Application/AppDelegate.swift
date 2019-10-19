//
//  AppDelegate.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private (set) var coordinator: ApplicationCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = ApplicationCoordinator(
            window: UIWindow(frame: UIScreen.main.bounds)
        )
        coordinator.start()
        return true
    }

}

