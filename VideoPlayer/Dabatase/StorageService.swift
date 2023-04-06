//
//  StorageService.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import CoreData
import Combine

final class StorageService {
    static let shared = StorageService()
    let updatesPublisher: AnyPublisher<Bool, Never>
    
    private lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "Database")
        container.setup()
        return container
    }()
    
    private init() {
        updatesPublisher = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    func getVideos() -> [VideoModel] {
        let models: [VideoCDM] = persistentContainer.getObjects() ?? []
        return models.map(VideoModel.init)
    }
    
    func getVideo(for id: String) -> VideoModel? {
        let model: VideoCDM? = persistentContainer.getObject(predicate: VideoCDM.objectPredicate(id: id))
        return model.map(VideoModel.init)
    }
    
    func saveVideo(_ video: VideoModel) {
        persistentContainer.createObject(type: VideoCDM.self, data: video)
    }
    
    func deleteVideo(_ video: VideoModel) {
        persistentContainer.deleteObjects(
            of: VideoCDM.self,
            predicate: VideoCDM.objectPredicate(id: video.id)
        )
        
        // TODO: Delete files on disk (video, image)
    }
}
