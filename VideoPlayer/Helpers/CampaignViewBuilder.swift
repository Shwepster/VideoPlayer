//
//  CampaignViewBuilder.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 14.04.2023.
//

import SwiftUI

enum CampaignViewBuilder {
    @ViewBuilder static func buildCampaign(for type: CampaignService.Campaign) -> some View {
        switch type {
        case .promo, .onboarding:
            Text(type.rawValue)
        }
    }
}
