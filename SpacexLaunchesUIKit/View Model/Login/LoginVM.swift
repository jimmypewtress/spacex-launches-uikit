//
//  LoginVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation

protocol LoginVM {
    var enableLoginButtonPublisher: Published<Bool>.Publisher { get }
    var emailTextFieldStatePublisher: Published<TextFieldState>.Publisher { get }
    var emailValidatedTextPublisher: Published<String>.Publisher { get }
    var passwordValidatedTextPublisher: Published<String>.Publisher { get }
    
    func validateEmail(textChange: TextChange)
    func validatePassword(textChange: TextChange)
    
    func forgotPasswordButtonTapped()
    func loginButtonTapped()
}

class LoginVMImpl: BaseVM, LoginVM, ObservableObject {
    @Published var enableLoginButton = false
    var enableLoginButtonPublisher: Published<Bool>.Publisher { $enableLoginButton }
    
    @Published var emailTextFieldState: TextFieldState = .normal
    var emailTextFieldStatePublisher: Published<TextFieldState>.Publisher { $emailTextFieldState }
    
    @Published var emailValidatedText: String = ""
    var emailValidatedTextPublisher: Published<String>.Publisher { $emailValidatedText }
    
    @Published var passwordValidatedText: String = ""
    var passwordValidatedTextPublisher: Published<String>.Publisher { $passwordValidatedText }
    
    @Published private var emailIsValid: Bool = false
    @Published private var passwordIsValid: Bool = false
    
    private let uc: LoginUC
    private let forgotPasswordCoordinator: NavigationCoordinator
    
    private lazy var emailValidators: [TextChange.Validator] = [
        .init(rule: .regex(Constants.Validation.regex.email.rawValue),
              action: { [weak self] in
                  guard let self = self else { return .hardFailure }
                  
                  self.emailTextFieldState = .invalid
                  return .softFailure
        }),
        .init(rule: .alwaysTrue,
              action: { [weak self] in
                  guard let self = self else { return .hardFailure }
                  
                  self.emailTextFieldState = .valid
                  return .success
        })
    ]
    
    private lazy var passwordValidators: [TextChange.Validator] = [
        .init(rule: .minLength(Constants.Validation.Length.loginPassword.min),
              action: { [weak self] in
                  guard let self = self else { return .hardFailure }
                  
                  return .softFailure
        }),
        .init(rule: .maxLength(Constants.Validation.Length.loginPassword.max),
              action: { [weak self] in
                  guard let self = self else { return .hardFailure }
                  
                  return .hardFailure
        }),
        .init(rule: .alwaysTrue,
              action: { [weak self] in
                  guard let self = self else { return .hardFailure }

                  return .success
        })
    ]
    
    init(uc: LoginUC,
         forgotPasswordCoordinator: NavigationCoordinator) {
        self.uc = uc
        self.forgotPasswordCoordinator = forgotPasswordCoordinator
    }
    
    override func subscribe() {
        $emailIsValid.combineLatest($passwordIsValid).sink { tuple in
            self.enableLoginButton = tuple.0 && tuple.1
        }.store(in: &cancellables)
        
        self.uc.loginSuccessPublisher.sink { loginSuccess in
            if loginSuccess {
                self.reset()
            }
        }.store(in: &cancellables)
    }
    
    func validateEmail(textChange: TextChange) {
        let validationResult = textChange.validate(self.emailValidators)
        
        if textChange.newText == "" {
            self.emailTextFieldState = .normal
        }
        
        if validationResult != .hardFailure {
            self.emailIsValid = validationResult == .success
            self.emailValidatedText = textChange.newText
        }
    }
    
    func validatePassword(textChange: TextChange) {
        let validationResult = textChange.validate(self.passwordValidators)
        
        if validationResult != .hardFailure {
            self.passwordIsValid = validationResult == .success
            self.passwordValidatedText = textChange.newText
        }
    }
    
    func forgotPasswordButtonTapped() {
        self.forgotPasswordCoordinator.start()
    }
    
    func loginButtonTapped() {
        self.uc.login(email: self.emailValidatedText, password: self.passwordValidatedText)
    }
    
    private func reset() {
        self.emailValidatedText = ""
        self.passwordValidatedText = ""
        self.emailTextFieldState = .normal
    }
}
