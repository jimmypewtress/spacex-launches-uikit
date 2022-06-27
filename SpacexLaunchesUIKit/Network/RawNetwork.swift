//
//  RawNetwork.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation
import Combine

protocol RawNetwork {
    func makeAsyncRequest(_ rawRequest: RawRequest) -> Future<RawResponse, Never>
}

class RawNetworkImpl: RawNetwork {
    private var cancellables: Set<AnyCancellable> = []
    
    private let environment: Environment
    private let urlSession: URLSession?
    
    init(environment: Environment) {
        self.environment = environment
        self.urlSession = URLSession(configuration: .ephemeral)
    }
    
    func makeAsyncRequest(_ rawRequest: RawRequest) -> Future<RawResponse, Never> {
        var (optionalUrlRequest, rawResponse) = self.composeRequest(rawRequest)
        
        return Future() { promise in
            guard let urlRequest = optionalUrlRequest else {
                promise(Result.success(rawResponse))
                return
            }
            
            self.urlSession?.dataTaskPublisher(for: urlRequest)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        rawResponse.urlErrorCode = error.errorCode
                        rawResponse.urlErrorLocalizedDescription = error.localizedDescription
                        promise(Result.success(rawResponse))
                    default:
                        break
                    }
                }, receiveValue: { (data: Data, response: URLResponse) in
                    guard let response = response as? HTTPURLResponse else {
                        rawResponse.networkingError = .noHttpResponse
                        promise(Result.success(rawResponse))
                        return
                    }
                    
                    rawResponse.httpStatusCode = response.statusCode
                    rawResponse.data = data
                    
                    promise(Result.success(rawResponse))
                }).store(in: &self.cancellables)
        }
    }
    
    private func composeRequest(_ requestData: RawRequest) -> (URLRequest?, RawResponse) {
        let endpointProperties = Constants.API.EndpointProperties(
            endpoint: requestData.endpoint,
            environment: self.environment
        )
        
        var rawResponse = RawResponse()
        var urlComponents = URLComponents()
        
        guard let host = endpointProperties.host else {
            rawResponse.networkingError = .noHostForEndpoint
            return (nil, rawResponse)
        }
        
        let path = String(format: endpointProperties.fullPath, arguments: requestData.endpointParams)
        
        urlComponents.scheme = endpointProperties.connectionProtocol
        urlComponents.host = host
        urlComponents.path = path
        
        if let queryItems = requestData.queryItems {
            urlComponents.queryItems = queryItems.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
                
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")
        
        if let port = endpointProperties.port {
            urlComponents.port = port
        }
        
        guard let url = urlComponents.url else {
            rawResponse.networkingError = .cannotCreateUrl
            return (nil, rawResponse)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestData.endpoint.httpMethod.rawValue
        request.timeoutInterval = Double(endpointProperties.timeoutInterval)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = endpointProperties.contentType
        headers["Accept"] = endpointProperties.contentType
        
        if let additionalHeaders = requestData.headers {
            headers.merge(additionalHeaders) { (_, new) in new }
        }

        request.allHTTPHeaderFields = headers
        
        request.httpBody = requestData.requestBody
        request.timeoutInterval = endpointProperties.timeoutInterval

        return (request, rawResponse)
    }
}
