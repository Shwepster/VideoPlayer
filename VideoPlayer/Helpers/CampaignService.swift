//
//  CampaignService.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 14.04.2023.
//

import Combine
import Foundation

final class CampaignService {
    var campaignSubject = PassthroughSubject<Campaign, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupTimer()
    }
    
    private func showPromo(of type: Campaign) {
        campaignSubject.send(type)
    }
    
    private func setupTimer() {
        Timer.TimerPublisher(interval: 15, runLoop: .main, mode: .default)
            .autoconnect()
            .sink { [weak self] _ in
                let campaign = Campaign.allCases.randomElement()!
                self?.showPromo(of: campaign)
            }
            .store(in: &subscriptions) 
    }
}

// MARK: - Campaign

extension CampaignService {
    enum Campaign: String, CaseIterable, Identifiable {
        case promo
        case onboarding
        
        var id: String { self.rawValue }
    }
}
