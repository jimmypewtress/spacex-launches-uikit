//
//  RawResponse.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation

typealias NetworkingError = Constants.Error.Network

struct RawResponse {
    var networkingError: NetworkingError?
    var urlErrorCode: Int?
    var urlErrorLocalizedDescription: String?
    var httpStatusCode: Int?
    var data: Data?
    
    var json: Any? {
        if let data = self.data {
            return try? JSONSerialization
                .jsonObject(with: data, options: [])
        }
        return nil
    }
}
