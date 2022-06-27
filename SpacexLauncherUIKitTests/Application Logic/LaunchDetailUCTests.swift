//
//  LaunchDetailUCTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 27/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LaunchDetailUCTests: TestCase {
    
    var sut: LaunchDetailUC!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        self.sut = r.launchDetail.uc
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try? super.tearDownWithError()
    }

    func testSuccessfulRequest() throws {
        self.network.launchResponse.data = Sample.launch.launchData
        self.network.launchpadResponse.data = Sample.launchpad.launchpadData
        self.network.rocketResponse.data = Sample.rocket.rocketData
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        
        var sinkCalledCounter = 0
        
        self.sut.combinedLaunchPublisher.sink { combinedLaunch in
            sinkCalledCounter += 1
            
            if sinkCalledCounter == 2 {
                XCTAssertNotNil(combinedLaunch)
                willReturnDataExpectation.fulfill()
                
                XCTAssertEqual(combinedLaunch!.date, Date(timeIntervalSince1970: 1275677100))
                XCTAssertEqual(combinedLaunch!.description, "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.")
                XCTAssertEqual(combinedLaunch!.imageUrl, "https://images2.imgbox.com/d6/12/yxne8mMD_o.png")
                XCTAssertEqual(combinedLaunch!.launchpadName, "CCSFS SLC 40")
                XCTAssertEqual(combinedLaunch!.rocketName, "Falcon 9")
                XCTAssertEqual(combinedLaunch!.youTubeId, "nxSxgBKlYws")
                
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunchDeatails(launchId: "123")
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSuccessfulRequestNoDescription() throws {
        self.network.launchResponse.data = Sample.launch.launchData
        self.network.launchpadResponse.data = Sample.launchpad.launchpadData
        self.network.rocketResponse.data = Sample.rocket.rocketDataNoDescrption
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        
        var sinkCalledCounter = 0
        
        self.sut.combinedLaunchPublisher.sink { combinedLaunch in
            sinkCalledCounter += 1
            
            if sinkCalledCounter == 2 {
                XCTAssertNotNil(combinedLaunch)
                willReturnDataExpectation.fulfill()

                XCTAssertEqual(combinedLaunch!.description, Constants.Strings.General.unknown)
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunchDeatails(launchId: "123")
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testUnsuccessfulLaunchRequest() {
        self.network.launchResponse.networkingError = .deserializationIssue
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        willReturnDataExpectation.isInverted = true
        
        var sinkCalledCounter = 0
        
        self.sut.combinedLaunchPublisher.sink { combinedLaunch in
            sinkCalledCounter += 1
            
            if (combinedLaunch != nil) {
                willReturnDataExpectation.fulfill()
            }
            
            if sinkCalledCounter == 2 {
                XCTFail("should only get called once")
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunchDeatails(launchId: "123")
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testUnsuccessfulLaunchpadRequest() {
        self.network.launchResponse.data = Sample.launch.launchData
        self.network.rocketResponse.data = Sample.rocket.rocketData
        
        self.network.launchpadResponse.networkingError = .deserializationIssue
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        willReturnDataExpectation.isInverted = true
        
        var sinkCalledCounter = 0
        
        self.sut.combinedLaunchPublisher.sink { combinedLaunch in
            sinkCalledCounter += 1
            
            if (combinedLaunch != nil) {
                willReturnDataExpectation.fulfill()
            }
            
            if sinkCalledCounter == 2 {
                XCTFail("should only get called once")
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunchDeatails(launchId: "123")
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testUnsuccessfulRocketRequest() {
        self.network.launchResponse.data = Sample.launch.launchData
        self.network.launchpadResponse.data = Sample.launchpad.launchpadData
        
        self.network.rocketResponse.networkingError = .deserializationIssue
        
        let willReturnDataExpectation = expectation(description: "will return some data")
        willReturnDataExpectation.isInverted = true
        
        var sinkCalledCounter = 0
        
        self.sut.combinedLaunchPublisher.sink { combinedLaunch in
            sinkCalledCounter += 1
            
            if (combinedLaunch != nil) {
                willReturnDataExpectation.fulfill()
            }
            
            if sinkCalledCounter == 2 {
                XCTFail("should only get called once")
            }
        }.store(in: &cancellables)
        
        sut.fetchLaunchDeatails(launchId: "123")
        
        waitForExpectations(timeout: 0.1)
    }
}
