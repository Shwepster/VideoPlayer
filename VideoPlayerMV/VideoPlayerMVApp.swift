//
//  VideoPlayerMVApp.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI

@main
struct VideoPlayerMVApp: App {
    @StateObject private var videoManager = VideoManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(videoManager)
        }
    }
}
