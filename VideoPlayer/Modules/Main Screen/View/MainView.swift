//
//  MainView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    @StateObject private var videoViewModel = VideoList.ViewModel()

    
    var body: some View {
        NavigationStack {
            VideoList(viewModel: videoViewModel)
                .navigationTitle("Imported Videos")
                .toolbar {
                    if viewModel.importState == .idle {
                        VideoPicker(videoSelection: $viewModel.videoSelection)
                            .padding()
                    } else {
                        ProgressView()
                        .padding()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let viewModel = MainView.ViewModel(videoImporter: .init())
    static var previews: some View {
        MainView(viewModel: viewModel)
    }
}
