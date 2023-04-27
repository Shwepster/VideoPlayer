//
//  SwipeToDismiss.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 10.04.2023.
//

import SwiftUI

public struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    var changeOpacity = true
    @State private var offset: CGSize = .zero
    
    public init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(offset == .zero ? 1 : 0.97)
            .opacity(calculateOpacity())
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
    
    private func calculateOpacity() -> CGFloat {
        if offset == .zero { return 1 }

        let divider: CGFloat = 250
        let verticalOffset = abs(offset.height) / divider
        let opacity = 1 - verticalOffset
        return max(opacity, 0.75)
    }
}
