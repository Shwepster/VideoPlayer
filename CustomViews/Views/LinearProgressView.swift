//
//  LinearProgressView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 26.04.2023.
//

import SwiftUI

public struct LinearProgressView: View {
    @State private var width: CGFloat = 0
    @State private var offset: CGFloat = 0

    public init() {}
    
    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                .overlay(
                    Rectangle()
                        .foregroundColor(Color.accentColor)
                        .frame(width: geometry.width * 0.25)
                        .clipShape(Capsule())
                        .offset(x: -geometry.width * 0.7, y: 0)
                        .offset(x: geometry.width * 1.15 * offset, y: 0)
                        .animation(.default.repeatForever().speed(0.265), value: offset)
                )
                .clipShape(Capsule())
                .onAppear {
                    withAnimation {
                        offset = 1
                    }
                }
        }
    }
}
