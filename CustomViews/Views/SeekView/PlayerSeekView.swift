//
//  PlayerSeekView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 10.04.2023.
//

import SwiftUI

public struct PlayerSeekView: View {
    let onSeekForward: () -> Void
    let onSeekBack: () -> Void
    
    public init(onSeekForward: @escaping () -> Void, onSeekBack: @escaping () -> Void) {
        self.onSeekForward = onSeekForward
        self.onSeekBack = onSeekBack
    }
    
    public var body: some View {
        HStack {
            SeekPartView(
                side: .left,
                onDoubleTap: onSeekBack
            )
            
            SeekPartView(
                side: .right,
                onDoubleTap: onSeekForward
            )
        }
    }
}

struct PlayerSeekView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSeekView {
            
        } onSeekBack: {
            
        }
        .background(Color.purple)
    }
}
