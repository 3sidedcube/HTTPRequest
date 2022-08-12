//
//  String+Data.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 18/10/2020.
//

import Foundation

// MARK: - StringDataError

/// An `Error` converting from `String` to `Data` or vice versa
public enum StringDataError: Error {

    /// Failed to create a `String` from the given `Data` and `String.Encoding`
    case data(Data, encoding: String.Encoding)

    /// Failed to create `Data` from the given `String` and `String.Encoding`
    case string(String, encoding: String.Encoding)
}

// MARK: - String + Data

public extension String {

    /// `String` instance to `Data` or throw
    ///
    /// - Note:
    /// Consider using `Data(self.utf8))`
    ///
    /// - Parameter encoding: `String.Encoding`
    func dataOrThrow(encoding: String.Encoding) throws -> Data {
        guard let data = data(using: encoding) else {
            throw StringDataError.string(self, encoding: encoding)
        }
        return data
    }
}

// MARK: - Data + String

public extension Data {

    /// `Data` instance to `String` or throw
    ///
    /// - Note:
    /// Consider using `String(decoding: self, as: UTF8.self)` for UTF8
    ///
    /// - Parameter encoding: `String.Encoding`
    func stringOrThrow(encoding: String.Encoding) throws -> String {
        guard let string = String(data: self, encoding: encoding) else {
            throw StringDataError.data(self, encoding: encoding)
        }
        return string
    }
}
