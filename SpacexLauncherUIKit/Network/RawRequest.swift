//
//  RawRequest.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation

struct RawRequest {
    var endpoint: Constants.API.Endpoint
    var headers: [String: String]?
    var requestBody: Data?
    var queryItems: [String: String]?
    var endpointParams: [String] = []
    
    init(endpoint: Constants.API.Endpoint) {
        self.endpoint = endpoint
    }
}

extension RawRequest {
    //  return nil if encoding body or headers fails
    init?(_ payload: Encodable? = nil,
          headers: Encodable? = nil,
          queryItems: Encodable? = nil,
          endpointParams: [String] = [],
          endpoint: Constants.API.Endpoint) {
        var requestBody: Data?
        var headerMap: [String: String]?
        var queryItemsMap: [String: String]?
              
        if let payload = payload {
            if endpoint.httpMethod == .post || endpoint.httpMethod == .put {
                requestBody = payload.encodeToRequestBody()
                
                if requestBody == nil {
                    return nil
                }
            }
        }
        
        if let headers = headers {
            headerMap = headers.encodeToStringDictionary()
            if headerMap == nil {
                return nil
            }
        }
        
        if let queryItems = queryItems {
            queryItemsMap = queryItems.encodeToStringDictionary()
            if queryItemsMap == nil {
                return nil
            }
        }
        
        self.init(endpoint: endpoint)
        self.requestBody = requestBody
        self.headers = headerMap
        self.endpointParams = endpointParams
        self.queryItems = queryItemsMap
    }
}
