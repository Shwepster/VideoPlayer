//
//  PlayerProgressViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import AVKit
import Combine
import Model

extension PlayerProgressView {
    @MainActor class ViewModel: ObservableObject {
        @Published var totalTimeText: String
        @Published var currentTimeText: String
        
        @Published var isEditing: Bool
        @Published var totalTime: Double
        @Published var currentTime: Double {
            didSet {
                if isEditing {
                    // Seek if user is manually scrolling
                    engine.seek(to: currentTime)
                }
                               
                currentTimeText = Self.timeToString(time: currentTime)
            }
        }
        private var subscriptions = Set<AnyCancellable>()
        private var engine: VideoPlayerEngine
        private let updateFrequency: Double = 0.5
       
        init(engine: VideoPlayerEngine) {
            self.engine = engine
            self.isEditing = false
            self.currentTime = engine.currentTime
            self.currentTimeText = Self.timeToString(time: engine.currentTime)
            self.totalTime = 0
            self.totalTimeText = Self.timeToString(time: 0)
            subscribe()
        }
        
        deinit {
            NSLog("ProgressView.VM deinit")
        }
        
        func didDraw(with width: CGFloat) async {
            engine.subscribeOnProgress(forWidth: width, updateFrequency: updateFrequency)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] time in
                    // Update only when user is not manually scrolling time
                    if self?.isEditing == false {
                        self?.currentTime = time
                    }                    
                }
                .store(in: &subscriptions)
        }
        
        // MARK: - Private

        private func subscribe() {
            engine.$duration
                .receive(on: DispatchQueue.main)
                .compactMap(\.?.seconds)
                .sink { [weak self] time in
                    self?.totalTime = time
                    self?.totalTimeText = Self.timeToString(time: time)
                }
                .store(in: &subscriptions)
        }
        
        static func timeToString(time: Double) -> String {
            let timeInterval = Int(time)
            let seconds = timeInterval % 60
            let minutes = (timeInterval / 60) % 60
            let hours = timeInterval / 3600
            
            let formattedString = hours > 0
            ? String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            : String(format: "%02d:%02d", minutes, seconds)
            
            return formattedString
        }
    }
}
