//
//  ForgotPasswordVMTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class ForgotPasswordVMTests: TestCase {
    
    func textChange(_ text: String) -> TextChange {
        return TextChange(oldText: text,
                          changeRange: NSRange(location: 0, length: 0),
                          replacementString: "")
    }
    
    var sut: ForgotPasswordVM!
    var uc: MockedForgotPasswordUC!
    var dismissModalCoordinator: MockedNavigationCoordinator!
    var coordinatorNavigationController: UINavigationController!
    var alertManager: MockedAlertManager!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        self.uc = MockedForgotPasswordUC()
        r.forgotPassword.uc = self.uc
        
        self.alertManager = MockedAlertManager()
        r.alert.manager = alertManager
        
        self.dismissModalCoordinator = .init()
        
        r.forgotPassword.input = .init(dismissModalCoordinator: self.dismissModalCoordinator)
        
        self.sut = r.forgotPassword.vm
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.uc = nil
        self.dismissModalCoordinator = nil
        
        try? super.tearDownWithError()
    }

    func testNoTextEntered() {
        let expectedEmailStringValue = ""
        
        sut.emailValidatedTextPublisher.sink { stringValue in
            XCTAssertEqual(stringValue, expectedEmailStringValue)
        }.store(in: &cancellables)
        
        let expectedEmailTextFieldState: TextFieldState = .normal
        
        sut.emailTextFieldStatePublisher.sink { textFieldState in
            XCTAssertEqual(textFieldState, expectedEmailTextFieldState)
        }.store(in: &cancellables)
    }
    
    func testEmailValidationNoAt() {
        let emailString = "abc"
        
        let expectedEmailStringValue = "abc"
        var validatedTextCounter = 0
        let emailValidCountExpection = expectation(description: "value will change twice")
        
        sut.emailValidatedTextPublisher.sink { stringValue in
            validatedTextCounter += 1
            
            if validatedTextCounter == 2 {
                XCTAssertEqual(stringValue, expectedEmailStringValue)
                emailValidCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        let expectedEmailTextFieldState: TextFieldState = .invalid
        var stateCounter = 0
        let emailTextFieldStateCountExpection = expectation(description: "value will change twice")
        
        sut.emailTextFieldStatePublisher.sink { textFieldState in
            stateCounter += 1
            
            if stateCounter == 2 {
                XCTAssertEqual(textFieldState, expectedEmailTextFieldState)
                emailTextFieldStateCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: self.textChange(emailString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testEmailValidationNoDomain() {
        let emailString = "abc@efg"
        
        let expectedEmailStringValue = "abc@efg"
        var validatedTextCounter = 0
        let emailValidCountExpection = expectation(description: "value will change twice")
        
        sut.emailValidatedTextPublisher.sink { stringValue in
            validatedTextCounter += 1
            
            if validatedTextCounter == 2 {
                XCTAssertEqual(stringValue, expectedEmailStringValue)
                emailValidCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        let expectedEmailTextFieldState: TextFieldState = .invalid
        var stateCounter = 0
        let emailTextFieldStateCountExpection = expectation(description: "value will change twice")
        
        sut.emailTextFieldStatePublisher.sink { textFieldState in
            stateCounter += 1
            
            if stateCounter == 2 {
                XCTAssertEqual(textFieldState, expectedEmailTextFieldState)
                emailTextFieldStateCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: self.textChange(emailString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testEmailValidationCorrect() {
        let emailString = "abc@efg.com"
        
        let expectedEmailStringValue = "abc@efg.com"
        var validatedTextCounter = 0
        let emailValidCountExpection = expectation(description: "value will change twice")
        
        sut.emailValidatedTextPublisher.sink { stringValue in
            validatedTextCounter += 1
            
            if validatedTextCounter == 2 {
                XCTAssertEqual(stringValue, expectedEmailStringValue)
                emailValidCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        let expectedEmailTextFieldState: TextFieldState = .valid
        var stateCounter = 0
        let emailTextFieldStateCountExpection = expectation(description: "value will change twice")
        
        sut.emailTextFieldStatePublisher.sink { textFieldState in
            stateCounter += 1
            
            if stateCounter == 2 {
                XCTAssertEqual(textFieldState, expectedEmailTextFieldState)
                emailTextFieldStateCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: self.textChange(emailString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testEmailValidationAddTextThenDelete() {
        let emailString1 = "a"
        let emailString2 = ""
        
        let expectedEmailStringValue = ""
        var validatedTextCounter = 0
        let emailValidCountExpection = expectation(description: "value will change three times")
        
        sut.emailValidatedTextPublisher.sink { stringValue in
            validatedTextCounter += 1
            
            if validatedTextCounter == 3 {
                XCTAssertEqual(stringValue, expectedEmailStringValue)
                emailValidCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        let expectedEmailTextFieldState: TextFieldState = .normal
        var stateCounter = 0
        let emailTextFieldStateCountExpection = expectation(description: "value will change four times")
        
        sut.emailTextFieldStatePublisher.sink { textFieldState in
            stateCounter += 1
            
            if stateCounter == 4 {
                XCTAssertEqual(textFieldState, expectedEmailTextFieldState)
                emailTextFieldStateCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: self.textChange(emailString1))
        sut.validateEmail(textChange: self.textChange(emailString2))
        
        waitForExpectations(timeout: 0.1)
    }

    func testSendLinkButtonStateNoEmail() {
        let expectedSendLinkButtonEnabledValue = false
        var enableCounter = 0
        let enableSendLinkCountExpection = expectation(description: "value will change once")
        
        sut.enableSendLinkButtonPublisher.sink { enableValue in
            enableCounter += 1
            
            if enableCounter == 1 {
                XCTAssertEqual(enableValue, expectedSendLinkButtonEnabledValue)
                enableSendLinkCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSendLinkButtonStateInvalidEmail() {
        let emailString = "abc"

        let expectedSendLinkButtonEnabledValue = false
        var enableCounter = 0
        let enableSendLinkCountExpection = expectation(description: "value will change twice")

        sut.enableSendLinkButtonPublisher.sink { enableValue in
            enableCounter += 1

            if enableCounter == 2 {
                XCTAssertEqual(enableValue, expectedSendLinkButtonEnabledValue)
                enableSendLinkCountExpection.fulfill()
            }

        }.store(in: &cancellables)

        sut.validateEmail(textChange: textChange(emailString))

        waitForExpectations(timeout: 0.1)
    }
    
    func testSendLinkButtonStateValidEmail() {
        let emailString = "abc@def.com"

        let expectedSendLinkButtonEnabledValue = true
        var enableCounter = 0
        let enableSendLinkCountExpection = expectation(description: "value will change twice")

        sut.enableSendLinkButtonPublisher.sink { enableValue in
            enableCounter += 1

            if enableCounter == 2 {
                XCTAssertEqual(enableValue, expectedSendLinkButtonEnabledValue)
                enableSendLinkCountExpection.fulfill()
            }

        }.store(in: &cancellables)

        sut.validateEmail(textChange: textChange(emailString))

        waitForExpectations(timeout: 0.1)
    }
    
    func testCancelButtonAction() {
        expectNavigationCoordinatorToStart(self.dismissModalCoordinator)
        
        self.sut.cancelButtonTapped()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSendLinkButtonAction() {
        let emailString = "abc@def.com"
        
        self.sut.validateEmail(textChange: textChange(emailString))
        self.sut.sendLinkButtonTapped()
        
        XCTAssertEqual(self.uc.requestedEmail, emailString)
    }
    
    func testSuccessResponseHandler() {
        let emailString = "abc@def.com"
        
        self.sut.validateEmail(textChange: textChange(emailString))
        
        self.uc.shouldReturnSuccess = true
        self.sut.sendLinkButtonTapped()
        
        XCTAssertTrue(self.alertManager.alertWasCreated)
        XCTAssertEqual(self.alertManager.alertTitle, Constants.Strings.ForgotPassword.successAlertTitle)
        XCTAssertEqual(self.alertManager.alertMessage, Constants.Strings.ForgotPassword.successAlertMessage)
        
        XCTAssertNotNil(self.alertManager.actions.first)
        
        expectNavigationCoordinatorToStart(self.dismissModalCoordinator)
        
        let alertAction = self.alertManager.actions.first!
        let dummyAction = UIAlertAction()
        
        alertAction(dummyAction)
        
        waitForExpectations(timeout: 1.1)
    }
}
