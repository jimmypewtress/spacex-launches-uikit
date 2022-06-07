//
//  Resolver+Login.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

extension Resolver {
    class LoginResolver: SubResolver {
        lazy var vc = { [unowned self] () -> UIViewController in
            return LoginVC.createVC(
                viewModel: self.vm
            )
        }()
        
        lazy var vm = { [unowned self] () -> LoginVM in
            return LoginVMImpl()
        }()
    }
}
