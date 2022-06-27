//
//  LaunchDetailVMTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 27/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LaunchDetailVMTests: TestCase {
    
    var sut: LaunchDetailVM!
    var input: LaunchDetailVMInput!
    var uc: MockedLaunchDetailUC!
    var mockedExternalUrlCoordinator: MockedCoordinatorOf<String>!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        self.mockedExternalUrlCoordinator = .init()
        self.input = LaunchDetailVMInput(id: "123", rocketName: "inputRocketName")
        
        r.launchDetail.input = .init(.init(input: self.input, externalUrlCoordintor: self.mockedExternalUrlCoordinator))
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.uc = nil
        self.mockedExternalUrlCoordinator = nil
        
        try? super.tearDownWithError()
    }

    func testTableDataSourcePopulationOptionalsPresent() {
        let jun272020 = Date(timeIntervalSince1970: 1656320639)
        
        let sampleUCOutput = CombinedLaunch(imageUrl: "imageUrl",
                                           rocketName: "rocketName",
                                           date: jun272020,
                                           launchpadName: "launchpadName",
                                           description: "description",
                                           youTubeId: "youTubeId")
        
        self.uc = .init()
        self.uc.output = sampleUCOutput
        r.launchDetail.uc = self.uc
        
        self.sut = r.launchDetail.vm

        let dataIsPopulatedExpectation = expectation(description: "data gets populated")
        var tableChangedCounter = 0
        
        self.sut.tableDataChangedSubject.sink(receiveCompletion: { _ in }) { val in
            tableChangedCounter += 1
            
            if tableChangedCounter == 1 {
                if self.sut.tableRows.count > 0 {
                    dataIsPopulatedExpectation.fulfill()
                    
                    if let imageRow = self.sut.tableRows[0] as? DetailRow, case .image(let model) = imageRow {
                        XCTAssertEqual(model.url, sampleUCOutput.imageUrl)
                    } else {
                        XCTFail("image cell vm model not configured")
                    }
                    
                    if let headingRow1 = self.sut.tableRows[1] as? DetailRow, case .heading(let model) = headingRow1 {
                        XCTAssertEqual(model.heading, sampleUCOutput.rocketName)
                    } else {
                        XCTFail("heading cell vm model not configured")
                    }
                    
                    if let infoRow1 = self.sut.tableRows[3] as? DetailRow, case .info(let model) = infoRow1 {
                        XCTAssertEqual(model.heading, Constants.Strings.Launches.DetailCell.date)
                        XCTAssertEqual(model.text, DateFormatter.dayMonthYear.string(from: jun272020) + ":")
                    } else {
                        XCTFail("info cell vm model not configured")
                    }
                    
                    if let infoRow2 = self.sut.tableRows[5] as? DetailRow, case .info(let model) = infoRow2 {
                        XCTAssertEqual(model.heading, Constants.Strings.Launches.DetailCell.launchpad + ":")
                        XCTAssertEqual(model.text, sampleUCOutput.launchpadName)
                    } else {
                        XCTFail("info cell vm model not configured")
                    }
                    
                    if let headingRow2 = self.sut.tableRows[7] as? DetailRow, case .heading(let model) = headingRow2 {
                        XCTAssertEqual(model.heading, Constants.Strings.Launches.DetailCell.description)
                    } else {
                        XCTFail("heading cell vm model not configured")
                    }
                    
                    if let textRow = self.sut.tableRows[9] as? DetailRow, case .text(let model) = textRow {
                        XCTAssertEqual(model.text, sampleUCOutput.description)
                    } else {
                        XCTFail("text cell vm model not configured")
                    }
                    
                    if let buttonRow = self.sut.tableRows[12] as? DetailRow, case .button(let model) = buttonRow {
                        XCTAssertEqual(model.title, Constants.Strings.Launches.DetailCell.watchVideo)
                        XCTAssertTrue(model.enabled)
                    } else {
                        XCTFail("button cell vm model not configured")
                    }
                }
            }
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testTableDataSourcePopulationOptionalsNil() {
        let jun272020 = Date(timeIntervalSince1970: 1656320639)
        
        let sampleUCOutput = CombinedLaunch(imageUrl: nil,
                                           rocketName: "outputRocketName",
                                           date: jun272020,
                                           launchpadName: "launchpadName",
                                           description: "description",
                                           youTubeId: nil)
        
        self.uc = .init()
        self.uc.output = sampleUCOutput
        r.launchDetail.uc = self.uc
        
        self.sut = r.launchDetail.vm

        let dataIsPopulatedExpectation = expectation(description: "data gets populated")
        var tableChangedCounter = 0
        
        self.sut.tableDataChangedSubject.sink(receiveCompletion: { _ in }) { val in
            tableChangedCounter += 1
            
            if tableChangedCounter == 1 {
                if self.sut.tableRows.count > 0 {
                    dataIsPopulatedExpectation.fulfill()
                    
                    if let imageRow = self.sut.tableRows[0] as? DetailRow, case .image(let model) = imageRow {
                        XCTAssertNil(model.url)
                    } else {
                        XCTFail("image cell vm model not configured")
                    }
                    
                    if let buttonRow = self.sut.tableRows[12] as? DetailRow, case .button(let model) = buttonRow {
                        XCTAssertEqual(model.title, Constants.Strings.Launches.DetailCell.watchVideo)
                        XCTAssertFalse(model.enabled)
                    } else {
                        XCTFail("button cell vm model not configured")
                    }
                }
            }
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testInitialRocketName() {
        self.uc = .init()

        r.launchDetail.uc = self.uc
        
        self.sut = r.launchDetail.vm
        
        XCTAssertEqual(self.sut.selectedRocketName, self.input.rocketName)
    }
    
    func testApiCallUpdatesRocketName() {
        let jun272020 = Date(timeIntervalSince1970: 1656320639)

        let sampleUCOutput = CombinedLaunch(imageUrl: nil,
                                           rocketName: "rocketName",
                                           date: jun272020,
                                           launchpadName: "launchpadName",
                                           description: "description",
                                           youTubeId: nil)
        
        self.uc = .init()
        self.uc.output = sampleUCOutput
        r.launchDetail.uc = self.uc
        
        self.sut = r.launchDetail.vm

        let rocketNameIsUpdatedExpectation = expectation(description: "rocket name is changed")
        var tableChangedCounter = 0

        self.sut.tableDataChangedSubject.sink(receiveCompletion: { _ in }) { val in
            tableChangedCounter += 1

            if tableChangedCounter == 1 {
                if self.sut.selectedRocketName == sampleUCOutput.rocketName {
                    rocketNameIsUpdatedExpectation.fulfill()
                }
            }
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testRowSelected() {
        let jun272020 = Date(timeIntervalSince1970: 1656320639)
        
        let sampleUCOutput = CombinedLaunch(imageUrl: "imageUrl",
                                           rocketName: "rocketName",
                                           date: jun272020,
                                           launchpadName: "launchpadName",
                                           description: "description",
                                           youTubeId: "youTubeId")
        
        self.uc = .init()
        self.uc.output = sampleUCOutput
        r.launchDetail.uc = self.uc
        
        self.sut = r.launchDetail.vm

        let expectedInput = Constants.Strings.YouTube.baseUrl + sampleUCOutput.youTubeId!
        
        expectCoordinatorToStart(self.mockedExternalUrlCoordinator, with: expectedInput)
        
        self.sut.didSelectRow(self.sut.tableRows[12])
        
        waitForExpectations(timeout: 0.1)
    }
}
