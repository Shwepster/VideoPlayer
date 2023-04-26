//
//  VideoItemView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import SwiftUI

public struct VideoItemView: View {
    let title: String
    var imageURL: URL?
    
    public init(title: String, imageURL: URL? = nil) {
        self.title = title
        self.imageURL = imageURL
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            ItemImageView(url: imageURL)
            
            LinearGradient(
                gradient: Gradient(colors: [.black, .clear]),
                startPoint: .bottom,
                endPoint: .init(x: 0.5, y: 0.75)
            )
            
            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(
            color: .primary.opacity(0.5),
            radius: 4
        )
    }
}
