//
//  VideoPlayerApp.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

@main
struct VideoPlayerApp: App {
    let mainViewModel = MainViewModel(videoImporter: .init())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: mainViewModel)
        }
    }
}