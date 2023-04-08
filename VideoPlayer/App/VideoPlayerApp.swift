//
//  VideoPlayerApp.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

@main
struct VideoPlayerApp: App {
    @StateObject private var mainViewModel = MainView.ViewModel(videoImporter: .init())
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
             MainView(viewModel: mainViewModel)
        }
    }
}
