//
//  ForgotPasswordVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

class ForgotPasswordVC: BaseVC {
    private var viewModel: ForgotPasswordVM!
    
    // MARK: - Constructor
    class func createVC(viewModel: ForgotPasswordVM) -> ForgotPasswordVC {
        return Utils.createVC(storyboard: .forgotPassword) { vc in
            vc.viewModel = viewModel
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var headingLabel: StyledLabel!
    @IBOutlet weak var subheadingLabel: StyledLabel!
    @IBOutlet weak var textfieldTitleLabel: StyledLabel!
    @IBOutlet weak var cancelButton: StyledButton!
    @IBOutlet weak var emailTextField: StyledTextField!
    @IBOutlet weak var sendLinkButton: StyledButton!
    @IBOutlet weak var sendLinkButtonBottomConstraint: NSLayoutConstraint!
    
    private let strings = Constants.Strings.self
    
    override var keyboardRect: CGRect?
    {
        didSet {
            guard let newValue = self.keyboardRect,
            let currentWindow = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else {
                return
            }

            let safeAreaTop = currentWindow.safeAreaInsets.top
            let offset = UIScreen.main.bounds.height - newValue.origin.y - safeAreaTop + self.sendLinkButton.frame.size.height
            
            self.sendLinkButtonBottomConstraint.constant = offset < 0 ? Constants.MagicNumbers.defaultKeyboardOffset.cgFloat : offset
            
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }
    
    override func subscribe() {
        self.viewModel.enableSendLinkButtonPublisher.sink { enableSendLinkButton in
            self.sendLinkButton.isEnabled = enableSendLinkButton
        }.store(in: &cancellables)
        
        self.viewModel.emailTextFieldStatePublisher.sink { state in
            self.emailTextField.textFieldState = state
        }.store(in: &cancellables)
        
        self.viewModel.emailValidatedTextPublisher.sink { validText in
            self.emailTextField.text = validText
        }.store(in: &cancellables)
    }
    
    private func configureUI() {
        self.headingLabel.text = strings.ForgotPassword.heading
        self.subheadingLabel.text = strings.ForgotPassword.subHeading
        self.textfieldTitleLabel.text = strings.General.email
        self.emailTextField.placeholder = strings.Login.emailTextFieldPlaceHolder
        self.cancelButton.setTitle(strings.General.cancel, for: .normal)
        self.sendLinkButton.setTitle(strings.ForgotPassword.sendLinkButtonTitle, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.viewModel.cancelButtonTapped()
    }
    
    @IBAction func sendLinkButtonTapped(_ sender: Any) {
        self.viewModel.sendLinkButtonTapped()
    }
}

// MARK: - Text Field Delegate
extension ForgotPasswordVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let textChange = TextChange(oldText: textField.text ?? "",
                                    changeRange: range,
                                    replacementString: string)
        
        switch textField {
        case self.emailTextField:
            self.viewModel.validateEmail(textChange: textChange)
        default:
            // TODO: put some error handling here in case of an unhandled text field
            break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        
        return true
    }
}
