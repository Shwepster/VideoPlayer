//
//  WatermarkView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 07.04.2023.
//

import SwiftUI

struct WatermarkView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("CocoaMex")
                    .fontDesign(.serif)
                    .bold()
                    .italic()
                    .foregroundColor(.white.opacity(0.5))
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Capsule(style: .continuous))
                    .padding()
                Spacer()
            }
            Spacer()
        }
    }
}

struct WatermarkView_Previews: PreviewProvider {
    static var previews: some View {
        WatermarkView()
            .background(Color.purple)
    }
}
