//
//  SeekPartView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 10.04.2023.
//

import SwiftUI

struct SeekPartView: View {
    let side: Side
    let onDoubleTap: () -> Void
    @State private var isArrowsShown = false
    
    var body: some View {
        GeometryReader { geometry in
            Color.black
                .opacity(0.0001)
                .frame(width: geometry.size.width)
                .overlay {
                    if isArrowsShown {
                        Image(systemName: "chevron.\(side).2")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .padding(geometry.size.width / 8)
                            .background(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(
                                cornerRadius: geometry.size.width / 4
                            ))
                            .scaleEffect(0.8, anchor: side.anchor)
                            .padding(.horizontal)
                            .transition(
                                .opacity
                                .combined(with: .scale(scale: 0.9))
                            )
                    }
                }
                .onTapGesture(count: 2) {
                    withAnimation {
                        isArrowsShown = true
                        withAnimation(.default.delay(0.3)) {
                            isArrowsShown = false
                        }
                    }
                    
                    onDoubleTap()
                }
        }
    }
}

extension SeekPartView {
    enum Side: String {
        case left
        case right
        
        var anchor: UnitPoint {
            switch self {
            case .left:
                return .leading
            case .right:
                return .trailing
            }
        }
    }
}

struct SeekPartView_Previews: PreviewProvider {
    static var previews: some View {
        SeekPartView(side: .left) {}
            .background(Color.red)
    }
}
