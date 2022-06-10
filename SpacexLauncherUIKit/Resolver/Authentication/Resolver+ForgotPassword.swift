//
//  Resolver+ForgotPassword.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

extension Resolver {
    class ForgotPasswordResolver: SubResolver {
        lazy var vc = { [unowned self] () -> UIViewController in
            return ForgotPasswordVC.createVC(
                viewModel: self.vm
            )
        }()
        
        lazy var vm = { [unowned self] () -> ForgotPasswordVM in
            return ForgotPasswordVMImpl(uc: self.uc)
        }()
        
        lazy var uc = { [unowned self] () -> ForgotPasswordUC in
            return ForgotPasswordUCImpl()
        }()
    }
}
