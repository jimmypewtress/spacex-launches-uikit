//
//  LaunchListVMTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LaunchListVMTests: TestCase {
    
    var sut: LaunchListVM!
    var uc: MockedLaunchListUC!
    var detailCoordinator: MockedNavigationCoordinatorOf<LaunchDetailVMInput>!
    var logoutUC: MockedLogoutUC!

    override func setUpWithError() throws {
        try? super.setUpWithError()

        self.uc = .init()
        r.launchList.uc = self.uc

        self.detailCoordinator = .init(navigationViewController: nil)
        r.launchList.input = .init(detailCoordinator: self.detailCoordinator)
        
        self.logoutUC = .init()
        r.logout.uc = self.logoutUC

        self.sut = r.launchList.vm
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.uc = nil
        self.detailCoordinator = nil
        self.logoutUC = nil
        
        try? super.tearDownWithError()
    }

    func testTableDataSourcePopulation() {
        self.uc.output = Sample.launches.launchesList

        let dateIsPopulatedExpectation = expectation(description: "data gets populated")
        var tableChangedCounter = 0
        
        self.sut.tableDataChangedSubject.sink { _ in }
            receiveValue: { val in
                tableChangedCounter += 1
                
                if tableChangedCounter == 2 {
                    if self.sut.tableSections.count > 0 {
                        dateIsPopulatedExpectation.fulfill()
                    }
                    
                    XCTAssertEqual(self.sut.tableSections.count, 4)
                    XCTAssertEqual(self.sut.tableSections[0], Date(timeIntervalSince1970: 1669852800))
                    XCTAssertEqual(self.sut.tableSections[1], Date(timeIntervalSince1970: 1661986800))
                    XCTAssertEqual(self.sut.tableSections[2], Date(timeIntervalSince1970: 1659308400))
                    XCTAssertEqual(self.sut.tableSections[3], Date(timeIntervalSince1970: 1656630000))
                    
                    XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[0]]?.count, 1)
                    XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[1]]?.count, 2)
                    XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[2]]?.count, 3)
                    XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[3]]?.count, 4)
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[0]]?[0] {
                        XCTAssertEqual(model.id, "6243aec2af52800c6e91925d")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[1]]?[0] {
                        XCTAssertEqual(model.id, "628025222c0aa958437dcf76")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[1]]?[1] {
                        XCTAssertEqual(model.id, "6243ae58af52800c6e91925a")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[2]]?[0] {
                        XCTAssertEqual(model.id, "62a9f89a20413d2695d8871a")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[2]]?[1] {
                        XCTAssertEqual(model.id, "62a9f86420413d2695d88719")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[2]]?[2] {
                        XCTAssertEqual(model.id, "62a9f8b320413d2695d8871b")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[3]]?[0] {
                        XCTAssertEqual(model.id, "6243ae40af52800c6e919259")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[3]]?[1] {
                        XCTAssertEqual(model.id, "62a9f0f820413d2695d88714")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[3]]?[2] {
                        XCTAssertEqual(model.id, "62a9f0e320413d2695d88713")
                    }
                    
                    if case .cell(let model) = self.sut.tableRows[self.sut.tableSections[3]]?[3] {
                        XCTAssertEqual(model.id, "62a9f12820413d2695d88716")
                    }
                }
            }.store(in: &cancellables)

        self.sut.fetchData(isRefresh: true)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSpinnerGetsAddedOnPrefetchAndThenDisappearsWhenNewDataComes() {
        self.uc.output = Sample.launches.launchesList

        let spinnerNotThereExpectation = expectation(description: "spinner not there")
        let spinnerIsAddedExpectation = expectation(description: "spinner gets added")
        let spinnerIsRemovedExpectation = expectation(description: "spinner gets removed")
        
        var tableChangedCounter = 0
        
        self.sut.tableDataChangedSubject.sink { _ in }
            receiveValue: { val in
                tableChangedCounter += 1
                
                if tableChangedCounter == 2 {
                    if case .cell(_) = self.sut.tableRows[self.sut.tableSections[3]]?[3] {
                        XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[3]]?.count, 4)
                        spinnerNotThereExpectation.fulfill()
                    }
                }
                
                if tableChangedCounter == 3 {
                    if case .spinner = self.sut.tableRows[self.sut.tableSections[3]]?[4] {
                        XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[3]]?.count, 5)
                        spinnerIsAddedExpectation.fulfill()
                    }
                }
                
                if tableChangedCounter == 4 {
                    XCTAssertEqual(self.sut.tableRows[self.sut.tableSections[3]]?.count, 8)
                    
                    if self.sut.tableRows[self.sut.tableSections[3]]?.count == 8 {
                        spinnerIsRemovedExpectation.fulfill()
                    }
                }
            }.store(in: &cancellables)

        self.sut.fetchData(isRefresh: true)
        self.sut.fetchData(isRefresh: false)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testFetchReturnsIfStillFectching() {
        self.uc.shouldReturn = false
        
        XCTAssertEqual(self.uc.fetchCalledCounter, 1)

        self.sut.fetchData(isRefresh: true)
        
        XCTAssertEqual(self.uc.fetchCalledCounter, 2)
        
        self.sut.fetchData(isRefresh: false)
        
        XCTAssertEqual(self.uc.fetchCalledCounter, 2)
    }
    
    func testLaunchSelected() {
        let selectedRow = LaunchRow.cell(LaunchCellVM(Sample.launches.launchesSingle!))
        
        let expectedInput = LaunchDetailVMInput(id: "6243aec2af52800c6e91925d", rocketName: "Falcon 9")
        
        expectNavigationCoordinatorToStart(self.detailCoordinator, with: expectedInput)
        
        self.sut.didSelectRow(selectedRow)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLogoutTapped() {
        XCTAssertEqual(self.logoutUC.logoutCalledCounter, 0)
        
        self.sut.logoutButtonTapped()
        
        XCTAssertEqual(self.logoutUC.logoutCalledCounter, 1)
    }
}
