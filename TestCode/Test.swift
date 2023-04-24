//
//  Test.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 15.04.2023.
//

import SwiftUI

public struct TestParentView: View {
    @ObservedObject var model: TestModel
    
    public init(model: TestModel) {
        self.model = model
    }
    
    public var body: some View {
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

public final class TestModel: ObservableObject {
    @Published var name: String = ""
    let id = UUID()
    
    public init() {}
    
    func changeName() {
        name = "\(UUID())"
        print("changed name - \(name)")
        
        var array = [10, 5, 2, 3, 7, 6, 8, 9, 1, 4]
        
        search()
    }
    
    deinit {
        print("TestModel DEINIT. \(id)")
    }
}


func search() {
    let array = [1, 4, 3, 7, 5]
    let target = 10
    
    var cache = [Int: Int]()
    
    for i in 0..<array.count {
        let diff = target - array[i]
        cache[diff] = i
    }
    
    for j in 0..<array.count {
        let value = array[j]
        
        if let partnerIndex = cache[value], partnerIndex != j {
            print("found: \(partnerIndex) + \(j)")
            break
        }
    }
}

var iterations = 0

func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    let pivot = array[0]
    var less = [Int]()
    var more = [Int]()
    var same = [Int]()
    
    array.forEach {
        if $0 < pivot {
            less.append($0)
        } else if pivot == $0 {
            same.append($0)
        } else {
            more.append($0)
        }
        
        iterations += 1
    }
    
    return quickSort(less) + same + quickSort(more)
}


func selectionSort(_ array: inout [Int]) -> [Int] {
    var iterations = 0

    for i in 0..<array.count {
        var minIndex = i
        
        for k in i+1..<array.count {
            if array[k] < array[minIndex] {
                minIndex = k
            }
            iterations += 1
        }
        
        array.swapAt(i, minIndex)
    }
    
    print(iterations)
    return array
}

func bubbleSort(_ array: inout [Int]) -> [Int] {
    var iterations = 0
    
    for _ in 0..<array.count {
        for j in 0..<array.count - 1 {
            if array[j + 1] > array[j] {
                array.swapAt(j + 1, j)
            }
            iterations += 1
        }
    }
    
    print(iterations)
    return array
}

func someSort(_ array: inout [Int]) -> [Int] {
    var iterations = 0
    for i in 0..<array.count {
        for j in i+1..<array.count {
            if array[i] < array[j] {
                array.swapAt(i, j)
            }
            iterations += 1
        }
        
    }
    
    print(iterations)
    return array
}
