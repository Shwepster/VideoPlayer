//
//  MainView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI
import CustomViews

struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VideoList(viewModel: viewModel.videoListViewModel)
                .navigationTitle("Your Videos")
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
    static let viewModel = MainView.ViewModel(videoImporter: AppServices.createMediaImporter())
    static var previews: some View {
        MainView(viewModel: viewModel)
    }
}
