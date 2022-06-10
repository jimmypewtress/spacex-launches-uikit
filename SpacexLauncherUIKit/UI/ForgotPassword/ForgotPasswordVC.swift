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
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.viewModel.cancelButtonTapped()
    }
}
