//
//  VideoImporter.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import PhotosUI
import SwiftUI
import Combine

final class VideoImporter {
    var state: CurrentValueSubject<State, Never> = .init(.empty)
    private var videoSelection: PhotosPickerItem?
    
    func loadVideo(from selection: PhotosPickerItem) {
        videoSelection = selection
        state.send(.loading)
        
        selection.loadTransferable(type: Image.self) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                guard selection == self.videoSelection else { return }
                
                switch result {
                case .success(let image?):
                    self.state.send(.loaded(image))
                case .success(nil):
                    self.state.send(.empty)
                case .failure:
                    self.state.send(.fail)
                }
            }
        }
    }
}

// MARK: - State

extension VideoImporter {
    enum State {
        case loading
        case fail
        case empty
        case loaded(Image)
    }
}
