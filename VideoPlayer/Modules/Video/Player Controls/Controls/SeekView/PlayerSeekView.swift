//
//  PlayerSeekView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 10.04.2023.
//

import SwiftUI

struct PlayerSeekView: View {
    let onSeekForward: () -> Void
    let onSeekBack: () -> Void
    
    var body: some View {
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
