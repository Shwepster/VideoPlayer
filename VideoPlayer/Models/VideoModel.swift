//
//  VideoModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import AVKit
import CoreTransferable

final class VideoModel {
    let id: String
    let videoURL: URL
    var imageURL: URL?
    
    var image: UIImage? {
        guard let imageURL else { return nil }
        return UIImage(contentsOfFile: imageURL.path())
    }
    
    var asset: AVURLAsset {
        .init(url: videoURL)
    }
   
    init(id: String, videoURL: URL, imageURL: URL? = nil) {
        self.id = id
        self.videoURL = videoURL
        self.imageURL = imageURL
    }
    
    init(_ cdm: VideoCDM) {
        id = cdm.id
        videoURL = cdm.videoURL
        imageURL = cdm.imageURL
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
            let fileName = "\(id).\(format)"
            
            NSLog("Format: \(format)")
            
            let directory = NSTemporaryDirectory()
            let targetURL = NSURL.fileURL(withPathComponents: [directory, fileName])!
                        
            NSLog("Target path: \(targetURL)")
            
            try FileManager.default.copyItem(at: received.file, to: targetURL)
            return Self.init(id: id, videoURL: targetURL)
        }
    }
}
