//
//  RequestAndResponse.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation

protocol RequestAndResponse {
    associatedtype Request: Encodable
    associatedtype Headers: Encodable
    associatedtype Response: Decodable
    
    static func toRawRequest(_ request: Request, headers: Headers) -> RawRequest?
}

extension RequestAndResponse {
    static func decodeResponse(_ data: RawResponse) -> Response? {
        return Response.decodeRawResponse(data)
    }
}

extension Decodable {
    static func decodeRequestBody(data: Data) -> Self? {
        return data.decode()
    }
    
    static func decodeRawResponse(_ data: RawResponse) -> Self? {
        guard let data = data.data else { return nil }
        return Self.decodeRequestBody(data: data)
    }
}

extension Encodable {
    func encodeToRequestBody() -> Data? {
        let encoder = JSONEncoder()
        
        return try? encoder.encode(self)
    }
    
    func encodeToDictionary() -> [String: Any]? {
        if let data = self.encodeToRequestBody() {
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dictionary
        }
        
        return nil
    }
    
    func encodeToStringDictionary() -> [String: String]? {
        guard let dict = self.encodeToDictionary() else { return nil }
        
        var stringDict = [String: String]()
        
        for (key, value) in dict {
            stringDict[key] = "\(value)"
        }
        
        return stringDict
    }
}
