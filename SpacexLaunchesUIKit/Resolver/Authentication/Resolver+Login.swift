//
//  Resolver+Login.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

extension Resolver {
    class LoginResolver: SubResolver {
        struct Input {
            var forgotPasswordCoordinator: NavigationCoordinator
        }
        
        var input: Input!
        
        lazy var vc = { [unowned self] () -> UIViewController in
            return LoginVC.createVC(viewModel: self.vm)
        }()
        
        lazy var vm = { [unowned self] () -> LoginVM in
            return LoginVMImpl(uc: self.uc, forgotPasswordCoordinator: input.forgotPasswordCoordinator)
        }()
        
        lazy var uc = { [unowned self] () -> LoginUC in
            return LoginUCImpl(session: self.resolver.session.uc)
        }()
    }
}
