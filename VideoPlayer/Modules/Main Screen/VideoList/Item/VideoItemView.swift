//
//  VideoItemView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import SwiftUI

struct VideoItemView: View {
    let video: VideoModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VideoItemImageView(uiImage: video.image)
            
            LinearGradient(
                gradient: Gradient(colors: [.black, .clear]),
                startPoint: .bottom,
                endPoint: .init(x: 0.5, y: 0.75)
            )
            
            Text(video.title)
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

struct VideoItemView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemView(video: PreviewHelper.videoModels[0])
    }
}
