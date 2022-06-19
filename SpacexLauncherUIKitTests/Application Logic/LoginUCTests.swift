//
//  LoginUCTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class LoginUCTests: TestCase {
    
    func testLogin() {
        let loggedOutExpectation = expectation(description: "user is in logged out state")
        let loggedInExpectation = expectation(description: "user is in logged in state")
        
        var userStateCounter = 0
        
        let sut = r.login.uc
        
        r.session.uc.userStatePublisher.sink { userState in
            userStateCounter += 1
            
            if userStateCounter == 1 {
                if userState == .loggedOut {
                    loggedOutExpectation.fulfill()
                }
            }
            
            if userStateCounter == 2 {
                if userState == .loggedIn {
                    loggedInExpectation.fulfill()
                }
            }
        }.store(in: &cancellables)
        
        sut.login(email: "abc@def.com", password: "xyz")
        
        waitForExpectations(timeout: 0.1)
    }
}
