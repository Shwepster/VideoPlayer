//
//  VideoModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import AVKit
import CoreTransferable

struct VideoModel: Identifiable {
    let id: String
    let title: String
    let videoURL: URL
    var imageURL: URL?
    
    var image: UIImage? {
        guard let imageURL else { return nil }
        return UIImage(contentsOfFile: imageURL.path())
    }
    
    var asset: AVURLAsset {
        .init(url: videoURL)
    }
   
    init(id: String, title: String, videoURL: URL, imageURL: URL? = nil) {
        self.id = id
        self.title = title
        self.videoURL = videoURL
        self.imageURL = imageURL
    }
    
    init(_ cdm: VideoCDM) {
        id = cdm.id
        title = cdm.title
        videoURL = URL.getPath(for: cdm.videoPath)
        imageURL = cdm.imagePath.map { URL.getPath(for: $0) }
    }
}

// MARK: - Equatable

extension VideoModel: Equatable {
    static func == (lhs: VideoModel, rhs: VideoModel) -> Bool {
        lhs.id       == rhs.id &&
        lhs.title    == rhs.title &&
        lhs.videoURL == rhs.videoURL &&
        lhs.imageURL == rhs.imageURL
    }
}

// MARK: - Transferable

extension VideoModel: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .audiovisualContent) { video in
            SentTransferredFile(video.videoURL)
        } importing: { received in
            let id = UUID().uuidString
            let format = received.file.pathExtension
            let targetURL = URL.getPath(for: id, format: format)
            let title = received.file
                .lastPathComponent
                .replacing(".\(format)", with: "")
                        
            try FileManager.default.copyItem(at: received.file, to: targetURL)
            return Self.init(id: id, title: title, videoURL: targetURL)
        }
    }
}
