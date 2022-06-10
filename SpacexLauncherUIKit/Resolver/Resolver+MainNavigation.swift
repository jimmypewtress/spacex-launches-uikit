//
//  Resolver+MainNavigation.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

extension Resolver {
    class MainNavigationResolver: SubResolver {
        lazy var vc = { [unowned self] () -> UIViewController in
            return MainNavigationVC.createVC(
                viewModel: self.vm
            )
            }()
        
        lazy var vm = { [unowned self] () -> MainNavigationVM in
            return MainNavigationVMImpl(
                session: self.resolver.session.uc
            )
            }()
    }
}
