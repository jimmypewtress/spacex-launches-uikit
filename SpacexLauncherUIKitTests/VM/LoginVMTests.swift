//
//  LoginVMTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

import XCTest

@testable import SpacexLauncherUIKit
class LoginVMTests: TestCase {
    
    func textChange(_ text: String) -> TextChange {
        return TextChange(oldText: text,
                          changeRange: NSRange(location: 0, length: 0),
                          replacementString: "")
    }
    
    var sut: LoginVM!
    var uc: MockedLoginUC!
    var forgotPasswordCoordinator: MockedNavigationCoordinator!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        self.uc = MockedLoginUC()
        r.login.uc = self.uc
        
        self.forgotPasswordCoordinator = .init()
        
        r.login.input = .init(forgotPasswordCoordinator: forgotPasswordCoordinator)
        
        self.sut = r.login.vm
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.uc = nil
        self.forgotPasswordCoordinator = nil
        
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
        
        let expectedPasswordStringValue = ""
        
        sut.passwordValidatedTextPublisher.sink { stringValue in
            XCTAssertEqual(stringValue, expectedPasswordStringValue)
        }.store(in: &cancellables)
        
        let expectedLoginButtonEnableValue = false
        
        sut.enableLoginButtonPublisher.sink { enableValue in
            XCTAssertEqual(enableValue, expectedLoginButtonEnableValue)
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
    
    func testPasswordValidationAddTextThenDelete() {
        let passwordString1 = "a"
        let passwordString2 = ""
        
        let expectedPasswordStringValue = ""
        var validatedTextCounter = 0
        let emailValidCountExpection = expectation(description: "value will change three times")
        
        sut.passwordValidatedTextPublisher.sink { stringValue in
            validatedTextCounter += 1
            
            if validatedTextCounter == 3 {
                XCTAssertEqual(stringValue, expectedPasswordStringValue)
                emailValidCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        sut.validatePassword(textChange: self.textChange(passwordString1))
        sut.validatePassword(textChange: self.textChange(passwordString2))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testPasswordTooManyCharactersEntered() {
        let passwordStringMaxLength = "abcdefgh"
        let passwordStringOneTooMany = "abcdefghj"
        
        let expectedPasswordStringValue = "abcdefgh"
        var validatedTextCounter = 0
        let passwordValidCountExpection = expectation(description: "value will change twice")
        
        sut.passwordValidatedTextPublisher.sink { stringValue in
            validatedTextCounter += 1
            
            if validatedTextCounter == 2 {
                XCTAssertEqual(stringValue, expectedPasswordStringValue)
                passwordValidCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        sut.validatePassword(textChange: self.textChange(passwordStringMaxLength))
        sut.validatePassword(textChange: self.textChange(passwordStringOneTooMany))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLoginButtonStateNoEmailValidPassword() {
        let passwordString = "abc"
        
        let expectedLoginButtonEnabledValue = false
        var enableCounter = 0
        let enableLoginCountExpection = expectation(description: "value will change twice")
        
        sut.enableLoginButtonPublisher.sink { enableValue in
            enableCounter += 1
            
            if enableCounter == 2 {
                XCTAssertEqual(enableValue, expectedLoginButtonEnabledValue)
                enableLoginCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        sut.validatePassword(textChange: textChange(passwordString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLoginButtonStateInvalidEmailValidPassword() {
        let emailString = "abc"
        let passwordString = "def"
        
        let expectedLoginButtonEnabledValue = false
        var enableCounter = 0
        let enableLoginCountExpection = expectation(description: "value will change three times")
        
        sut.enableLoginButtonPublisher.sink { enableValue in
            enableCounter += 1
            
            if enableCounter == 3 {
                XCTAssertEqual(enableValue, expectedLoginButtonEnabledValue)
                enableLoginCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: textChange(emailString))
        sut.validatePassword(textChange: textChange(passwordString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLoginButtonStateValidEmailValidNoPassword() {
        let emailString = "abc@def.com"
        
        let expectedLoginButtonEnabledValue = false
        var enableCounter = 0
        let enableLoginCountExpection = expectation(description: "value will change twice")
        
        sut.enableLoginButtonPublisher.sink { enableValue in
            enableCounter += 1
            
            if enableCounter == 2 {
                XCTAssertEqual(enableValue, expectedLoginButtonEnabledValue)
                enableLoginCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: textChange(emailString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLoginButtonStateValidEmailValidPassword() {
        let emailString = "abc@def.com"
        let passwordString = "ghi"
        
        let expectedLoginButtonEnabledValue = true
        var enableCounter = 0
        let enableLoginCountExpection = expectation(description: "value will change three times")
        
        sut.enableLoginButtonPublisher.sink { enableValue in
            enableCounter += 1
            
            if enableCounter == 3 {
                XCTAssertEqual(enableValue, expectedLoginButtonEnabledValue)
                enableLoginCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        sut.validateEmail(textChange: textChange(emailString))
        sut.validatePassword(textChange: textChange(passwordString))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testLoginButtonAction() {
        let emailString = "abc@def.com"
        let passwordString = "ghi"
        
        sut.validateEmail(textChange: textChange(emailString))
        sut.validatePassword(textChange: textChange(passwordString))
        
        sut.loginButtonTapped()
        
        XCTAssertEqual(self.uc.email, emailString)
        XCTAssertEqual(self.uc.password, passwordString)
    }
    
    func testForgotPasswordButtonAction() {
        expectNavigationCoordinatorToStart(self.forgotPasswordCoordinator)
        
        self.sut.forgotPasswordButtonTapped()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testResetOnSuccessfulLogin() {
        let emailString = "abc@def.com"
        let passwordString = "ghi"
        
        let expectedEmailStringValue = ""
        var validatedEmailTextCounter = 0
        let emailValidCountExpection = expectation(description: "value will change three times")
        
        sut.emailValidatedTextPublisher.sink { stringValue in
            validatedEmailTextCounter += 1
            
            if validatedEmailTextCounter == 3 {
                XCTAssertEqual(stringValue, expectedEmailStringValue)
                emailValidCountExpection.fulfill()
            }
            
        }.store(in: &cancellables)
        
        let expectedPasswordStringValue = ""
        var validatedPasswordTextCounter = 0
        let passwordValidCountExpection = expectation(description: "value will three times")
        
        sut.passwordValidatedTextPublisher.sink { stringValue in
            validatedPasswordTextCounter += 1
            
            if validatedPasswordTextCounter == 3 {
                XCTAssertEqual(stringValue, expectedPasswordStringValue)
                passwordValidCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        
        let expectedEmailTextFieldState: TextFieldState = .normal
        var stateCounter = 0
        let emailTextFieldStateCountExpection = expectation(description: "value will change three times")
        
        sut.emailTextFieldStatePublisher.sink { textFieldState in
            stateCounter += 1
            
            if stateCounter == 3 {
                XCTAssertEqual(textFieldState, expectedEmailTextFieldState)
                emailTextFieldStateCountExpection.fulfill()
            }
        }.store(in: &cancellables)
        
        self.uc.shouldLoginSuccessfully = true
        
        sut.validateEmail(textChange: self.textChange(emailString))
        sut.validatePassword(textChange: self.textChange(passwordString))
        sut.loginButtonTapped()
        
        waitForExpectations(timeout: 0.1)
    }
}
