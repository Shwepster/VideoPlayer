//
//  ImageView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 15.04.2023.
//

import SwiftUI

struct ImageView: View {
    let image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            image?
                .resizable()
                .scaledToFill()
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .contentShape(Rectangle())
                .animation(.default, value: image)
        }
    }
}

struct VideoItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: .init("kp"))
    }
}
