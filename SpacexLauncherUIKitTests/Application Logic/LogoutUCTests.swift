//
//  LogoutUCTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LogoutUCTests: TestCase {
    
    func testLogout() {
        let loggedOutExpectation1 = expectation(description: "user is in logged out state")
        let loggedInExpectation = expectation(description: "user is in logged in state")
        let loggedOutExpectation2 = expectation(description: "user is in logged out state")
        
        var userStateCounter = 0
        
        r.session.uc.userStatePublisher.sink { userState in
            userStateCounter += 1
            
            if userStateCounter == 1 {
                if userState == .loggedOut {
                    loggedOutExpectation1.fulfill()
                }
            }
            
            if userStateCounter == 2 {
                if userState == .loggedIn {
                    loggedInExpectation.fulfill()
                }
            }
            
            if userStateCounter == 3 {
                if userState == .loggedOut {
                    loggedOutExpectation2.fulfill()
                }
            }
        }.store(in: &cancellables)
        
        r.login.uc.login(email: "abc@def.com", password: "xyz")
        r.logout.uc.logout()
        
        waitForExpectations(timeout: 0.1)
    }
}
