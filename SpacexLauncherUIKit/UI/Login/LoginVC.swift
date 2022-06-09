//
//  LoginVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

class LoginVC: UIViewController {
    private var viewModel: LoginVM!
    
    // MARK: - Constructor
    class func createVC(viewModel: LoginVM) -> LoginVC {
        return Utils.createVC(storyboard: .login) { vc in
            vc.viewModel = viewModel
        }
    }
    
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
    
    private let strings = Constants.Strings.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conigureUI()
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
    
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        print("forgot password button tappped")
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("forgot password button tappped")
    }
}
