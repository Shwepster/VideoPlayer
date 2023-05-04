//
//  ViewImageFetcher.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import SwiftUI

enum ViewImageFetcher {
    static public func makeImage(from url: URL?, size: CGSize? = nil) async -> Image? {
        guard let url,
              let image = UIImage(contentsOfFile: url.path())
        else { return nil }
        
        if let size, let image = await image.byPreparingThumbnail(ofSize: size) {
            return Image(uiImage: image)
        }
        
        return Image(uiImage: image)
    }
}
