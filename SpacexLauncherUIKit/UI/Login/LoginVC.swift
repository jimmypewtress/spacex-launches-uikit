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
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.viewModel.loginButtonTapped()
    }
}
