//
//  ItemImageView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import SwiftUI

public struct ItemImageView: View {
    let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: url) {
                ($0.image ?? Image("kp"))
                    .resizable()
            }
            .scaledToFill()
            .frame(
                width: geometry.width,
                height: geometry.height
            )
            .contentShape(Rectangle())
            .animation(.default, value: url)
        }
    }
}
