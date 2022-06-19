//
//  MainNavigationVMTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class MainNavigationVMTests: TestCase {

    func testLogin() {
        let loggedOutExpectation = expectation(description: "nvaigation root is login")
        let loggedInExpectation = expectation(description: "navigation root is launches")
        
        var loginRootCounter = 0
        
        let sut = r.mainNavigation.vm
        
        sut.navigationRootPublisher.sink { navigatioRoot in
            loginRootCounter += 1
            
            if loginRootCounter == 1 {
                if navigatioRoot == .login {
                    loggedOutExpectation.fulfill()
                }
            }
            
            if loginRootCounter == 2 {
                if navigatioRoot == .launches {
                    loggedInExpectation.fulfill()
                }
            }
        }.store(in: &cancellables)
        
        r.session.uc.userDidLogin()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLogout() {
        let loggedOutExpectation1 = expectation(description: "nvaigation root is login")
        let loggedInExpectation = expectation(description: "navigation root is launches")
        let loggedOutExpectation2 = expectation(description: "nvaigation root is login")
        
        var loginRootCounter = 0
        
        let sut = r.mainNavigation.vm
        
        sut.navigationRootPublisher.sink { navigatioRoot in
            loginRootCounter += 1
            
            if loginRootCounter == 1 {
                if navigatioRoot == .login {
                    loggedOutExpectation1.fulfill()
                }
            }
            
            if loginRootCounter == 2 {
                if navigatioRoot == .launches {
                    loggedInExpectation.fulfill()
                }
            }
            
            if loginRootCounter == 3 {
                if navigatioRoot == .login {
                    loggedOutExpectation2.fulfill()
                }
            }
        }.store(in: &cancellables)
        
        r.session.uc.userDidLogin()
        r.session.uc.userDidLogout()
        
        waitForExpectations(timeout: 0.1)
    }
}
