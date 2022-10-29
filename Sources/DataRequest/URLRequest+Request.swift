//
//  URLRequest+Request.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 29/10/2022.
//

import Foundation
import Alamofire

public extension URLRequest {

    /// Execute the request and complete with the response
    ///
    /// - Parameters:
    ///   - queue: `DispatchQueue`
    ///   - completion: Data response completion handler
    func request(
        queue: DispatchQueue = .main,
        completion: @escaping (DataResponse) -> Void
    ) -> DataRequest {
        AF.request(self).execute(queue: queue, completion: completion)
    }

    /// Execute `request(queue:completion:)` synchronously
    /// - Returns: `DataResponse`
    func requestSync() -> DataResponse {
        DispatchGroup.wait { block in
            _ = request(queue: DispatchQueue.new) { newResult in
                block(newResult)
            }
        }
    }
}
