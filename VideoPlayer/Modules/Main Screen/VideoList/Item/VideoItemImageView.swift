//
//  VideoItemImageView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 15.04.2023.
//

import SwiftUI

struct VideoItemImageView: View {
    let uiImage: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            image
                .scaledToFill()
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .contentShape(Rectangle())
        }
    }
    
    @ViewBuilder var image: some View {
        if let uiImage {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image("kp")
                .resizable()
                .background(Color.purple)
        }
    }
}

struct VideoItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemImageView(uiImage: .init(named: "kp"))
    }
}
