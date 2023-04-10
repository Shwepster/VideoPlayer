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
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 {
                            offset = gesture.translation.multiplied(by: 0.5)
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
