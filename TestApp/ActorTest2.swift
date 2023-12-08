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
    
    nonisolated func notCorrectRenameUser(current: Bool = true) {
        Task {
            let user = await getUser(new: !current) // To fix this, need to make it in one transaction in isolated context ("correctRenameUser")
            user.name = "New Name"
            print("Current user: \(await self.user.name)") // test without this print
            print("Local user: \(user.name)") // test without this print
        }
    }
    
    func correctRenameUser(current: Bool = true) {
        Task { // can remove "Task" block
            let user = getUser(new: !current)
            user.name = "New Name"
            print("Current user: \(self.user.name)") // test without this print
            print("Local user: \(user.name)") // test without this print
        }
    }
    
    private func getUser(new: Bool) -> User {
        new ? .init() : user
    }
}

final class UserTest: Sendable {
    let userActor = UserActor()
    
    func start() {
        Task {
            await userActor.correctRenameUser()
        }
    }
}

final class SendableTest {
    private func doItLater(_ job: @Sendable @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: job)
    }
    
    private func procrastinate() {
//        var someVal = 1
        //            So the warning, in this case, is really “if someone changes this function and adds concurrency, or if I [the compiler] didn’t notice existing concurrency, you’re screwed.”
        
        let someVal = 1

        doItLater {
            print(someVal)
        }
    }
}
