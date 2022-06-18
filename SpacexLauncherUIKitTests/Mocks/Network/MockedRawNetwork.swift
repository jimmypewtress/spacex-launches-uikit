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
    var response = RawResponse()
    
    func makeAsyncRequest(_ rawRequest: RawRequest) -> Future<RawResponse, Never> {
        self.request = rawRequest
        
        return Future() { promise in
            promise(Result.success(self.response))
        }
    }
}
