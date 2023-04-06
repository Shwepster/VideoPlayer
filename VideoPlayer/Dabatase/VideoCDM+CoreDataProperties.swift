//
//  VideoCDM+CoreDataProperties.swift
//  
//
//  Created by Maxim Vynnyk on 05.04.2023.
//
//

import Foundation
import CoreData

extension VideoCDM {
    @NSManaged public var id: String
    @NSManaged public var videoURL: URL
    @NSManaged public var imageURL: URL?
    
    func update(_ data: Any) {
        guard let video = data as? VideoModel else { return }
        
        id = video.id
        videoURL = video.videoURL
        imageURL = video.imageURL
    }
}
