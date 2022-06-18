//
//  MockedCoordinatorOf.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

typealias Callback = (() -> Void)

class MockedCoordinatorOf<Type>: CoordinatorOf<Type> {
    var startObjects: [Type] = []
    var callback: Callback?
    
    override func start(_ obj: Type) {
        self.startObjects.append(obj)
        self.callback?()
    }
}

class MockedNavigationCoordinatorOf<Type>: NavigationCoordinatorOf<Type> {
    var startObjects: [Type] = []
    var callback: Callback?

    override func onStart(_ obj: Type, r: Resolver) {
        self.startObjects.append(obj)
        self.callback?()
    }
}

extension TestCase {
    func expectCoordinatorToStart<Type>(
        _ coordinator: CoordinatorOf<Type>,
        with obj: Type,
        file: StaticString = #file, line: UInt = #line
    ) where Type: Equatable {
        if let mockedCoordinator = coordinator as? MockedCoordinatorOf<Type> {
            let exp = expectation(description: "\(coordinator) started")
            
            mockedCoordinator.callback = {
                XCTAssertEqual(mockedCoordinator.startObjects.first, obj)
                exp.fulfill()
            }
        } else {
            XCTFail("Coordinator is not mocked", file: file, line: line)
        }
    }
    
    func expectNavigationCoordinatorToStart<Type>(
        _ coordinator: NavigationCoordinatorOf<Type>,
        with obj: Type,
        file: StaticString = #file, line: UInt = #line
    ) where Type: Equatable {
        if let mockedCoordinator = coordinator as? MockedNavigationCoordinatorOf<Type> {
            let exp = expectation(description: "\(coordinator) started")
            
            mockedCoordinator.callback = {
                XCTAssertEqual(mockedCoordinator.startObjects.first, obj)
                exp.fulfill()
            }
        } else {
            XCTFail("Coordinator is not mocked", file: file, line: line)
        }
    }
}
