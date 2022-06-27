//
//  MockedCoordinator.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class MockedNavigationCoordinator: NavigationCoordinator {
    convenience init () {
        self.init(navigationViewController: nil)
    }
    
    var callback: Callback?
    
    override func onStart(_ obj: Void, r: Resolver) {
        self.callback?()
    }
}

extension TestCase {
    func expectNavigationCoordinatorToStart(
        _ coordinator: NavigationCoordinator,
        file: StaticString = #file, line: UInt = #line
    ) {
        if let mockedCoordinator = coordinator as? MockedNavigationCoordinator {
            let startExpectation = expectation(description: "\(coordinator) started")
            mockedCoordinator.callback = {
                startExpectation.fulfill()
            }
        } else {
            XCTFail("Coordinator is not mocked", file: file, line: line)
        }
    }
}
