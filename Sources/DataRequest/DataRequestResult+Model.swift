//
//  DataRequestResult+Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

public extension DataRequestResult {

    /// Decode success into `T` or throw
    ///
    /// - Parameters:
    ///   - decoder: `JSONDecoder`
    func model<T: Decodable>(decoder: JSONDecoder) throws -> T {
        return try get().data.decode(with: decoder)
    }

    /// Map into model result of success type `T`
    ///
    /// - Parameters:
    ///   - decoder: `JSONDecoder`
    func modelResult<T: Decodable>(decoder: JSONDecoder) -> Result<T, Error> {
        return .init(catching: { try model(decoder: decoder) })
    }
}
