//
//  VideoList.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

struct VideoList: View {
    var images: [Image]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Divider()
                
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(0..<images.count, id: \.self) { index in
                        images[index]
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geometry.size.width / 2,
                                height: geometry.size.width / 2 / 1.4
                            )
                            .clipped()
                    }
                }
            }
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(images: [Image(systemName: "star")])
    }
}
