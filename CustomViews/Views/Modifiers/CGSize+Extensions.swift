//
//  CGSize+Extensions.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import Foundation

extension CGSize {
    func multiplied(by multiplier: CGFloat) -> CGSize {
        .init(
            width: width * multiplier,
            height: height * multiplier
        )
    }
}
