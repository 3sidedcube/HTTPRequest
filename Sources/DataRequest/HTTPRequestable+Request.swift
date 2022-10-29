//
//  HTTPRequestable+Request.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation
import Alamofire

/// Execute a HTTP request
public extension HTTPRequestable {

    /// Execute HTTP request calling back with `completion` on the given `queue`
    ///
    /// - Parameters:
    ///   - queue: `DispatchQueue`
    ///   - completion: `DataRequestCompletion`
    ///
    /// - Returns: `DataRequest`
    @discardableResult
    func request(
        queue: DispatchQueue = .main,
        completion: @escaping DataRequestCompletion
    ) -> DataRequest? {
        do {
            // Try construct a URLRequest
            let urlRequest = try httpRequest().asURLRequest()

            // Execute the (data) request completing with the response
            return urlRequest.request(queue: queue) { response in
                completion(DataRequestResult(response: response))
            }
        } catch {
            // Construction of URLRequest threw an error.
            // Push completion to back of queue
            queue.async {
                completion(.failure(.wrap(error)))
            }

            // No request was made
            return nil
        }
    }

    /// Execute `request(queue:completion:)` synchronously
    /// - Returns: `DataRequestResult`
    func requestSync() throws -> DataRequestResult {
        DispatchGroup.wait { block in
            _ = request(queue: DispatchQueue.new) { newResult in
                block(newResult)
            }
        }
    }
}
