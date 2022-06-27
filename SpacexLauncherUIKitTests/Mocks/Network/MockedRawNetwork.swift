//
//  MockedRawNetwork.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
import Combine
@testable import SpacexLauncherUIKit

class MockedRawNetwork: RawNetwork {
    var request: RawRequest?
    var launchesResponse = RawResponse()
    var launchResponse = RawResponse()
    var launchpadResponse = RawResponse()
    var rocketResponse = RawResponse()
    
    func makeAsyncRequest(_ rawRequest: RawRequest) -> Future<RawResponse, Never> {
        self.request = rawRequest
        
        return Future() { promise in
            switch rawRequest.endpoint {
            case .launches:
                promise(Result.success(self.launchesResponse))
            case .launch:
                promise(Result.success(self.launchResponse))
            case .launchpad:
                promise(Result.success(self.launchpadResponse))
            case .rocket:
                promise(Result.success(self.rocketResponse))
            }
        }
    }
}
