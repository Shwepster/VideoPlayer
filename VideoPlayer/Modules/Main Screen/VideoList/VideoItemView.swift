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
            imageNew
            
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
            radius: 4
        )
    }
    
    @ViewBuilder var image: some View {
        if video.image == nil {
            Image("kp")
                .resizable()
                .background(Color.purple)
        } else {
            Image(uiImage: video.image!)
                .resizable()
        }
    }
    
    @ViewBuilder var imageNew: some View {
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
}

struct VideoItemView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemView(video: PreviewHelper.videoModels[0])
    }
}
