//
//  ActorTests.swift
//  TestApp
//
//  Created by Maxim Vynnyk on 05.05.2023.
//

import Foundation

var timer: Timer?
func runTest() {
    timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
        counterTest()
    }
    
    timer?.fire()
}

fileprivate func counterTest() {
    let counter = Counter()
    print("========")
    
    (0...10).forEach { i in
        if i == 5 {
            Task.detached { [counter] in
                await counter.resetSlow(to: 10)
            }
        }
        
        Task.detached { [counter] in
            print(counter.increment())
        }
    }
}

fileprivate func storageTest(storage: CounterStorage) async {
    let counter = await storage.selectCounter()
}

final class Counter {
    var value = 0
    
    @discardableResult
    func increment() -> Int {
        value += 1
        return value
    }
    
    @MainActor
    func resetSlow(to newValue: Int) {
        value = 0
        
        for _ in 0..<newValue {
            increment()
        }
        
        assert(value == newValue)
    }
}

actor CounterStorage {
    var counters: [Counter] = []
    
    func selectCounter() -> Counter? {
        counters.first
    }
}
