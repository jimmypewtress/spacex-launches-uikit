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
    
    private var network: RawNetwork
    private var activityIndicator: ActivityIndicatorUC
    
    init(network: RawNetwork,
         activityIndicator: ActivityIndicatorUC) {
        self.network = network
        self.activityIndicator = activityIndicator
    }

    func fetch(_ requestData: RnR.Request,
               headers: RnR.Headers,
               showSpinner: Bool = true) -> Future<RnR.Response, APIRequestError> {
        return Future() { promise in
            
            guard let rawRequest = RnR.toRawRequest(requestData, headers: headers) else {
                // TODO: handle serialisation error
                promise(Result.failure(APIRequestError()))
                return
            }
            
            if showSpinner {
                self.activityIndicator.showLoader()
            }
            
            self.network.makeAsyncRequest(rawRequest).sink { rawResponse in
                self.activityIndicator.hideLoader()
                
                if let networkingError = rawResponse.networkingError {
                    networkingError.appError.show()
                    
                    promise(Result.failure(APIRequestError()))
                }
                
                if let httpStatusCode = rawResponse.httpStatusCode,
                   httpStatusCode != 200 {
                    NetworkingError.httpIssue.appError.show()
                    
                    promise(Result.failure(APIRequestError()))
                }
                
                if let _ = rawResponse.urlErrorCode,
                   let urlErrorocalisedDescription = rawResponse.urlErrorLocalizedDescription {
                    NetworkingError.urlError(description: urlErrorocalisedDescription).appError.show()
                    
                    promise(Result.failure(APIRequestError()))
                }
                
                guard let _ = rawResponse.data else {
                    NetworkingError.jsonInvalidIssue.appError.show()
                    promise(Result.failure(APIRequestError()))
                    return
                }
                
                guard let response = RnR.decodeResponse(rawResponse) else {
                    NetworkingError.deserializationIssue.appError.show()
                    promise(Result.failure(APIRequestError()))
                    return
                }
                
                promise(Result.success(response))
            }.store(in: &self.cancellables)
        }
    }
}
