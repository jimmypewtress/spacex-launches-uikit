//
//  LaunchCellVMTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LuanchCellVMTests: TestCase {
    let june19th2022 = Date(timeIntervalSince1970: 1655617249)
    let rocket = SingleRocket(name: "Falcon 9")
    let presentlinks = Links(patch: Patch(small: "smallUrl", large: "largeUrl"))
    let nilLinks = Links(patch: Patch(small: nil, large: nil))
    let id = "abc"
    
    func testDataPopulationWithNonOptionalValues() {
        let launch = ListLaunch(rocket: self.rocket,
                            success: true,
                            date: self.june19th2022,
                            links: self.presentlinks,
                            id: self.id)
        
        let sut = LaunchCellVM(launch)
        
        XCTAssertEqual(sut.rocketName, "Falcon 9")
        XCTAssertEqual(sut.dateString, "19 June 2022")
        XCTAssertEqual(sut.date, Date(timeIntervalSince1970: 1655617249))
        XCTAssertEqual(sut.id, "abc")
    }
    
    func testSuccessPopulationNonNil() {
        let launch = ListLaunch(rocket: self.rocket,
                            success: true,
                            date: self.june19th2022,
                            links: self.presentlinks,
                            id: self.id)
        
        let sut = LaunchCellVM(launch)
        
        XCTAssertNotNil(sut.success)
        XCTAssertEqual(sut.success, "True")
    }
    
    func testSuccessPopulationNil() {
        let launch = ListLaunch(rocket: self.rocket,
                            success: nil,
                            date: self.june19th2022,
                            links: self.presentlinks,
                            id: self.id)
        
        let sut = LaunchCellVM(launch)
        
        XCTAssertNotNil(sut.success)
        XCTAssertEqual(sut.success, Constants.Strings.General.unknown)
    }
    
    func testLinksNonNil() {
        let launch = ListLaunch(rocket: self.rocket,
                            success: true,
                            date: self.june19th2022,
                            links: self.presentlinks,
                            id: self.id)
        
        let sut = LaunchCellVM(launch)
        
        XCTAssertNotNil(sut.patchUrl)
        XCTAssertEqual(sut.patchUrl, "smallUrl")
    }
    
    func testLinksNil() {
        let launch = ListLaunch(rocket: self.rocket,
                            success: true,
                            date: self.june19th2022,
                            links: self.nilLinks,
                            id: self.id)
        
        let sut = LaunchCellVM(launch)
        
        XCTAssertNil(sut.patchUrl)
    }
}
