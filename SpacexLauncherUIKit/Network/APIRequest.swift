//
//  APIRequest.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation
import Combine

struct APIRequestError: Error { }

class ApiRequest<RnR: RequestAndResponse> {
    private var cancellables: Set<AnyCancellable> = []
    var network: RawNetwork!

    func fetch(_ requestData: RnR.Request,
               headers: RnR.Headers) -> Future<RnR.Response, APIRequestError> {
        return Future() { promise in
            
            guard let rawRequest = RnR.toRawRequest(requestData, headers: headers) else {
                // TODO: handle serialisation error
                promise(Result.failure(APIRequestError()))
                return
            }
            
            self.network.makeAsyncRequest(rawRequest).sink { rawResponse in
                if let networkingError = rawResponse.networkingError {
                    // TODO: handle networking error
                    promise(Result.failure(APIRequestError()))
                }
                
                if let httpStatusCode = rawResponse.httpStatusCode,
                   httpStatusCode != 200 {
                    // TODO: handle status code error
                    promise(Result.failure(APIRequestError()))
                }
                
                if let urlErrorCode = rawResponse.urlErrorCode,
                   let urlErrorocalisedDescription = rawResponse.urlErrorLocalizedDescription {
                    // TODO: handle URL error
                    promise(Result.failure(APIRequestError()))
                }
                
                guard let _ = rawResponse.data else {
                    //TODO: handle invalid json error
                    promise(Result.failure(APIRequestError()))
                    return
                }
                
                guard let response = RnR.decodeResponse(rawResponse) else {
                    //TODO: handle deserialisation error
                    promise(Result.failure(APIRequestError()))
                    return
                }
                
                promise(Result.success(response))
            }.store(in: &self.cancellables)
        }
    }
}
