//
//  ViewImageFetcher.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import SwiftUI

enum ViewImageFetcher {
    static func makeImage(from url: URL?) async -> Image? {
        guard let url,
              let image = UIImage(contentsOfFile: url.path())
        else { return nil }
        
        return Image(uiImage: image)
    }
}
