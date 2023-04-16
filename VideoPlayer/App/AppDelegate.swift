//
//  AppDelegate.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import Foundation
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIScrollView.appearance().isPagingEnabled = true
        return true
    }
}
