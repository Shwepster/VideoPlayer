//
//  SwipeToDismiss.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 10.04.2023.
//

import SwiftUI

extension CGSize {
    func multiplied(by multiplier: CGFloat) -> CGSize {
        .init(
            width: width * multiplier,
            height: height * multiplier
        )
    }
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(offset == .zero ? 1 : 0.97)
            .clipShape(Rectangle())
            .offset(y: offset.height)
            .ignoresSafeArea()
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if abs(gesture.translation.width) < 20, abs(gesture.translation.height) > 20 {
                            offset = gesture.translation.multiplied(by: 0.3)
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.height) > 100 {
                            onDismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}
