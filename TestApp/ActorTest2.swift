//
//  ActorTest2.swift
//  TestApp
//
//  Created by Maxim Vynnyk on 15.05.2023.
//

import Foundation

fileprivate final class User {
    var name = "Bob"
}

actor UserActor {
    private var user = User()
    
    nonisolated func renameUser(current: Bool = true) {
        Task {
            let user = await getUser(new: !current)
            user.name = "New Name"
            print("Current user: \(await self.user.name)") // test without this print
            print("Local user: \(user.name)") // test without this print
        }
    }
    
    private func getUser(new: Bool) -> User {
        new ? .init() : user
    }
}

final class UserTest {
    let userActor = UserActor()
    
    func start() {
        userActor.renameUser()
    }
}
