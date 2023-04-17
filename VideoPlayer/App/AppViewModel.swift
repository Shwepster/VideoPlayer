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
        let mainViewModel: MainView.ViewModel
        private let campaignService = CampaignService()
        private var subscriptions = Set<AnyCancellable>()
        
        init() {
            let mediaImporter = AppServices.createMediaImporter()
            self.mainViewModel = .init(videoImporter: mediaImporter)
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
