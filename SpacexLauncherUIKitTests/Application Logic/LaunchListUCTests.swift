//
//  LaunchListUCTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LaunchListUCTests: TestCase {
    
    var sut: LaunchListUC!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        self.sut = r.launchList.uc
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try? super.tearDownWithError()
    }

    func testSuccessfulRequest() {
        self.network.response.data = Sample.launch.launchesData
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        
        var sinkCalledCounter = 0
        
        self.sut.launchesOutputPublisher.sink { launchesOutput in
            sinkCalledCounter += 1
            
            if sinkCalledCounter == 2 {
                XCTAssertNotNil(launchesOutput)
                willReturnDataExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunches(currentIndex: 1, pageSize: 10, showSpinner: true)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testUnsuccessfulRequest() {
        self.network.response.networkingError = .deserializationIssue
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        willReturnDataExpectation.isInverted = true
        
        var sinkCalledCounter = 0
        
        self.sut.launchesOutputPublisher.sink { launchesOutput in
            sinkCalledCounter += 1
            
            if (launchesOutput != nil) {
                willReturnDataExpectation.fulfill()
            }
            
            if sinkCalledCounter == 2 {
                XCTFail("should only get called once")
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunches(currentIndex: 1, pageSize: 10, showSpinner: true)
        
        waitForExpectations(timeout: 0.1)
    }
}
