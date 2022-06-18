//
//  RawNetworkTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class RawNetworkTests: TestCase {
    
    var sut: RawNetwork!
    var environment: MockedEnvironment!
    
    override func setMockFlags() {
        self.mockNetwork = false
    }
    
    struct Dummy: RequestAndResponse {
        typealias Request = [String: String]
        typealias Headers = Payload.Empty
        typealias Response = [String: String]
        
        static func toRawRequest(_ request: [String: String], headers: Headers) -> RawRequest? {
            return RawRequest(request, endpoint: .launches)
        }
    }
    
    let dummyInput = ["sample": "input"]
    let dummyOutput = ["sample": "output"]

    func testNoHostError() {
        r.environment.env = MockedEnvironment()
        
        let sut = r.api.network
        
        sut.makeAsyncRequest(Dummy.toRawRequest(dummyInput, headers: .init())!).sink { response in
            XCTAssertNotNil(response.networkingError)
            XCTAssertEqual(response.networkingError, NetworkingError.noHostForEndpoint)
        }.store(in: &cancellables)
    }
    
    func testCannotCreateUrlError() {
        r.environment.env = MockedEnvironment(host: "api.spacexdata.com")
        
        let sut = r.api.network
        
        sut.makeAsyncRequest(Dummy.toRawRequest(dummyInput, headers: .init())!).sink { response in
            XCTAssertNotNil(response.networkingError)
            XCTAssertEqual(response.networkingError, NetworkingError.cannotCreateUrl)
        }.store(in: &cancellables)
    }
}



