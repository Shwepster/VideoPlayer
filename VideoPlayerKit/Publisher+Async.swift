//
//  Publisher+Async.swift
//  VideoPlayerKit
//
//  Created by Maxim Vynnyk on 03.05.2023.
//

import Combine

extension Publisher where Self.Failure == Never {
    public func asyncSink(receiveValue: @escaping ((Self.Output) async -> Void)) -> AnyCancellable {
        sink { output in
            Task {
                await receiveValue(output)
            }
        }
    }
}
