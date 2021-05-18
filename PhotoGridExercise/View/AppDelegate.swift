//
//  AppDelegate.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 16/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Configuration.setMeasurementUnit(value: .imperial)
        return true
    }
}

