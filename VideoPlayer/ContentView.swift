//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            VideoList(images: viewModel.images)
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
    static let viewModel = MainViewModel(videoImporter: .init())
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
