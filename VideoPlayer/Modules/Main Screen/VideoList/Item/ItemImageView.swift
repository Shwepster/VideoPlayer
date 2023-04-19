//
//  ItemImageView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import SwiftUI

struct ItemImageView: View {
    let url: URL?
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: url) {
                ($0.image ?? Image("kp"))
                    .resizable()
            }
            .scaledToFill()
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .contentShape(Rectangle())
            .animation(.default, value: url)
        }
    }
}

struct VideoItemURLImageView_Previews: PreviewProvider {
    static var previews: some View {
        ItemImageView(url: PreviewHelper.videoModels[0].imageURL)
    }
}
