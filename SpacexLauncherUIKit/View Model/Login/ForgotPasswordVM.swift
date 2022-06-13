//
//  ForgotPasswordVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import Combine
import UIKit

protocol ForgotPasswordVM {
    var enableSendLinkButtonPublisher: Published<Bool>.Publisher { get }
    var emailTextFieldStatePublisher: Published<TextFieldState>.Publisher { get }
    var emailValidatedTextPublisher: Published<String>.Publisher { get }
    
    func cancelButtonTapped()
    func sendLinkButtonTapped()
    func validateEmail(textChange: TextChange)
}

class ForgotPasswordVMImpl: BaseVM, ForgotPasswordVM {
    @Published var enableSendLinkButton = false
    var enableSendLinkButtonPublisher: Published<Bool>.Publisher { $enableSendLinkButton }
    
    @Published var emailTextFieldState: TextFieldState = .normal
    var emailTextFieldStatePublisher: Published<TextFieldState>.Publisher { $emailTextFieldState }
    
    @Published var emailValidatedText: String = ""
    var emailValidatedTextPublisher: Published<String>.Publisher { $emailValidatedText }
    
    private let uc: ForgotPasswordUC
    private let dismissModalCoordinator: NavigationCoordinator
    private let alertPresenter: AlertManager
    
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
    
    init(uc: ForgotPasswordUC,
         dismissModalCoordinator: NavigationCoordinator,
         alertPresenter: AlertManager) {
        self.uc = uc
        self.dismissModalCoordinator = dismissModalCoordinator
        self.alertPresenter = alertPresenter
    }
    
    override func subscribe() {
        self.uc.requestLinkSuccessPublisher.sink { success in
            if success {
                self.showSuccessAlert()
            }
        }.store(in: &cancellables)
    }
    
    func validateEmail(textChange: TextChange) {
        let validationResult = textChange.validate(self.emailValidators)
        
        if textChange.newText == "" {
            self.emailTextFieldState = .normal
        }
        
        if validationResult != .hardFailure {
            self.enableSendLinkButton = validationResult == .success
            self.emailValidatedText = textChange.newText
        }
    }
    
    func cancelButtonTapped() {
        self.dismissModalCoordinator.start()
    }
    
    func sendLinkButtonTapped() {
        self.uc.requestLink(email: self.emailValidatedText)
    }
    
    private func showSuccessAlert() {
        let alert = self.alertPresenter.alert(withTitle: Constants.Strings.ForgotPassword.successAlertTitle, message: Constants.Strings.ForgotPassword.successAlertMessage)

        alertPresenter.addAction(to: alert, withTitle: Constants.Strings.General.ok, style: .default, handler: { _ in
            self.dismissModalCoordinator.start()
        })
        
        alertPresenter.present(alert: alert, on: self.dismissModalCoordinator.navigationViewController?.presentedViewController)

        
        //self.dismissModalCoordinator.navigationViewController?.presentedViewController?.present(alert, animated: true)
    }
}
