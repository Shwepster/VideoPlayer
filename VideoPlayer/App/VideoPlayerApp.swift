//
//  VideoPlayerApp.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

@main
struct VideoPlayerApp: App {
    @StateObject private var viewModel = ViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var model: TestModel = .init()
    
    var body: some Scene {
        WindowGroup {
//            TestParentView(model: .init())
            MainView(viewModel: viewModel.mainViewModel)
                .sheet(item: $viewModel.campaign, content: CampaignViewBuilder.buildCampaign)
        }
    }
}
