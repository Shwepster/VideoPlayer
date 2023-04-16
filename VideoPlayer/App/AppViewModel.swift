//
//  AppViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 14.04.2023.
//

import Combine
import Foundation

extension VideoPlayerApp {
    @MainActor class ViewModel: ObservableObject {
        @Published var campaign: CampaignService.Campaign?
        let mainViewModel = MainView.ViewModel(videoImporter: .init())
        private let campaignService = CampaignService()
        private var subscriptions = Set<AnyCancellable>()
        
        init() {
            subscribeOnCampaigns()
        }
        
        private func subscribeOnCampaigns() {
            campaignService.campaignSubject
                .receive(on: DispatchQueue.main)
                .sink { [weak self] campaign in
                    self?.campaign = campaign
                }
                .store(in: &subscriptions)
        }
    }
}
