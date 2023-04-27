//
//  ImageView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 15.04.2023.
//

import SwiftUI

public struct ImageView: View {
    let image: Image?
    
    public init(image: Image?) {
        self.image = image
    }
    
    public var body: some View {
        GeometryReader { geometry in
            image?
                .resizable()
                .scaledToFill()
                .frame(
                    width: geometry.width,
                    height: geometry.height
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
