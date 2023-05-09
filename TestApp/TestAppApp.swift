//
//  TestAppApp.swift
//  TestApp
//
//  Created by Maxim Vynnyk on 05.05.2023.
//

import SwiftUI

@main
struct TestAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    runTest()
                }
        }
    }
}
