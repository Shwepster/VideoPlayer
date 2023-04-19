//
//  Test.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 15.04.2023.
//

import SwiftUI

struct TestParentView: View {
    @ObservedObject var model: TestModel
    
    var body: some View {
        ZStack {
            Color.purple.hueRotation(.degrees(Double.random(in: 0...360)))
            VStack {
                Text("TEST TEXT. \(model.name)")
                TestChildView(model: model)
            }
        }
    }
}

struct TestChildView: View {
    @ObservedObject var model: TestModel
    
    var body: some View {
        Button(action: {
            print("change name")
            model.changeName()
        }, label: {
            Text("Change Name")
        })
        Text("\(model.name)")
    }
}

class TestModel: ObservableObject {
    @Published var name: String = ""
    let id = UUID()
    
    func changeName() {
        name = "\(UUID())"
        print("changed name - \(name)")
    }
    
    deinit {
        print("TestModel DEINIT. \(id)")
    }
}
