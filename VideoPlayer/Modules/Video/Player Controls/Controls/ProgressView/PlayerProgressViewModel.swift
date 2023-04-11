//
//  PlayerProgressViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import AVKit
import Combine

extension PlayerProgressView {
    @MainActor class ViewModel: ObservableObject {
        @Published var totalTime = 0.0
        @Published var isEditing = false
        @Published var currentTime: Double {
            didSet {
                guard isEditing else { return }
            }
        }
        private var subscriptions = Set<AnyCancellable>()
        private var engine: VideoPlayerEngine
        private let updateFrequency = 0.5
        
        init(engine: VideoPlayerEngine) {
            self.engine = engine
            self.currentTime = engine.currentTime
            subscribe()
        }
        
        deinit {
            NSLog("ProgressView.VM deinit")
        }
        
        func didDraw(with width: CGFloat) async {
            print("didDraw")
            
            engine.subscribeOnProgress(forWidth: width, updateFrequency: updateFrequency)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] time in
                    // Update only when user is not manualy changing time
                    if self?.isEditing == false {
                        self?.currentTime = time
                    }                    
                }
                .store(in: &subscriptions)
        }
        
        // MARK: - Private

        private func subscribe() {
            engine.duration
                .compactMap(\.?.seconds)
                .assign(to: &$totalTime)
        }
    }
}
