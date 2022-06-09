//
//  LoginVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

class LoginVC: BaseVC {
    private var viewModel: LoginVM!
    
    // MARK: - Constructor
    class func createVC(viewModel: LoginVM) -> LoginVC {
        return Utils.createVC(storyboard: .login) { vc in
            vc.viewModel = viewModel
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var headingLabel: StyledLabel!
    @IBOutlet weak var subheadingLabel: StyledLabel!
    @IBOutlet weak var emailTextFieldHeadingLabel: StyledLabel!
    @IBOutlet weak var emailTextField: StyledTextField!
    @IBOutlet weak var passwordTextFieldHeadingLabel: StyledLabel!
    @IBOutlet weak var passwordTextField: StyledTextField!
    @IBOutlet weak var forgotPasswordButton: StyledButton!
    @IBOutlet weak var loginButton: StyledButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContent: UIView!
    
    @IBOutlet weak var loginButtoBottomConstraint: NSLayoutConstraint!
    
    private let strings = Constants.Strings.self
    
    override var keyboardRect: CGRect?
    {
        didSet {
            guard let newValue = self.keyboardRect,
            let currentWindow = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else {
                return
            }

            let safeAreaTop = currentWindow.safeAreaInsets.top
            let safeAreaBotton = currentWindow.safeAreaInsets.bottom
                
            let offset = self.view.frame.size.height - newValue.origin.y - safeAreaTop + self.loginButton.frame.size.height
            
            self.loginButtoBottomConstraint.constant = offset < 0 ? Constants.MagicNumbers.defaultKeyboardOffset.cgFloat : offset
            
            let buttonY = self.view.frame.height - offset - self.loginButton.frame.size.height - safeAreaBotton
            let keyboardOverlap = self.scrollViewContent.frame.height - buttonY + self.loginButton.frame.size.height

            if keyboardOverlap > 0 {
                scrollView.isScrollEnabled = true
                scrollView.setContentOffset(CGPoint(x: 0, y: keyboardOverlap), animated: true)
            } else {
                scrollView.isScrollEnabled = false
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conigureUI()
    }
    
    override func subscribe() {
        self.viewModel.enableLoginButtonPublisher.sink { enableLoginButton in
            self.loginButton.isEnabled = enableLoginButton
        }.store(in: &cancellables)
        
        self.viewModel.emailTextFieldStatePublisher.sink { state in
            self.emailTextField.textFieldState = state
        }.store(in: &cancellables)
        
        self.viewModel.emailValidatedTextPublisher.sink { validText in
            self.emailTextField.text = validText
        }.store(in: &cancellables)
        
        self.viewModel.passwordValidatedTextPublisher.sink { validText in
            self.passwordTextField.text = validText
        }.store(in: &cancellables)
    }
    
    private func conigureUI() {
        self.headingLabel.text = strings.General.login
        self.subheadingLabel.text = strings.Login.subHeading
        self.emailTextFieldHeadingLabel.text = strings.Login.emailTextFieldHeading
        self.emailTextField.placeholder = strings.Login.emailTextFieldPlaceHolder
        self.passwordTextFieldHeadingLabel.text = strings.General.password
        self.passwordTextField.placeholder = strings.General.password
        self.forgotPasswordButton.setTitle(strings.Login.forgotPasswordButtonTitle, for: .normal)
        self.loginButton.setTitle(strings.Login.loginButtonTitle, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        self.viewModel.forgotPasswordButtonTapped()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.viewModel.loginButtonTapped()
    }
}

// MARK: - Text Field Delegate
extension LoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let textChange = TextChange(oldText: textField.text ?? "",
                                    changeRange: range,
                                    replacementString: string)
        
        switch textField {
        case self.emailTextField:
            self.viewModel.validateEmail(textChange: textChange)
        case self.passwordTextField:
            self.viewModel.validatePassword(textChange: textChange)
        default:
            // TODO: put some error handling here in case of an unhandled test field
            break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        
        return true
    }
}
