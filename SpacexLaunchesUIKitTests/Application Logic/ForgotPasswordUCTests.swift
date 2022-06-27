//
//  ForgotPasswordUCTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class ForgotPasswordUCTests: TestCase {
    
    func testForgotPassword() {
        let noRequestExpectation = expectation(description: "no password link requested")
        let requestMadeExpectation = expectation(description: "password link requested")
        
        var linkRequestedCounter = 0
        
        let sut = r.forgotPassword.uc
        
        sut.requestLinkSuccessPublisher.sink { linkRequested in
            linkRequestedCounter += 1
            
            if linkRequestedCounter == 1 {
                if !linkRequested {
                    noRequestExpectation.fulfill()
                }
            }
            
            if linkRequestedCounter == 2 {
                if linkRequested {
                    requestMadeExpectation.fulfill()
                }
            }
        }.store(in: &cancellables)
        
        sut.requestLink(email: "abc@def.com")
        
        waitForExpectations(timeout: 0.1)
    }
}

