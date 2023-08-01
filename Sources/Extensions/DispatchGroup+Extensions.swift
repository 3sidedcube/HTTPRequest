//
//  DispatchGroup+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 29/10/2022.
//

import Foundation

extension DispatchGroup {

    /// Wait for `async` to return with `Target` and return
    /// 
    /// - Parameter async: Asynchronous functionality to fetch `Target`
    /// - Returns: `Target
    static func wait<Target>(async: (@escaping (Target) -> Void) -> Void) -> Target {
        // Target to return synchronously
        var target: Target!

        // Enter a group to wait on
        let group = DispatchGroup()
        group.enter()

        // Fetch target asynchronously
        async { newTarget in
            // Set request result
            target = newTarget

            // Leave group
            group.leave()
        }

        // Wait for group to finish and complete with target
        group.wait()
        return target
    }
}

// MARK: - DispatchQueue + Extensions

extension DispatchQueue {

    /// Make a new `DispatchQueue` from a `UUID` label
    static var new: DispatchQueue {
        DispatchQueue(label: UUID().uuidString)
    }
}
