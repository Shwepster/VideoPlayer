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
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                image(for: video)
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                
                LinearGradient(
                    gradient: Gradient(colors: [.black, .clear]),
                    startPoint: .bottom,
                    endPoint: .init(x: 0.5, y: 0.75)
                )
                
                Text(video.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(
                color: .primary.opacity(0.5),
                radius: 8
            )
        }
    }
    
    @ViewBuilder func image(for video: VideoModel) -> some View {
        if video.image == nil {
            Image(systemName: "star")
                .resizable()
                .background(Color.purple)
        } else {
            Image(uiImage: video.image!)
                .resizable()
        }
    }
}

struct VideoItemView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemView(video: PreviewHelper.videoModels[0])
    }
}
