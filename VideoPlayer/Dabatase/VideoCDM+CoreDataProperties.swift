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
    @NSManaged public var videoPath: String
    @NSManaged public var imagePath: String?
    
    func update(_ data: Any) {
        guard let video = data as? VideoModel else { return }
        
        id = video.id
        videoPath = video.videoURL.lastPathComponent
        imagePath = video.imageURL?.lastPathComponent
    }
}
