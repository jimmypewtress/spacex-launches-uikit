//
//  Resolver+LaunchList.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

extension Resolver {
    class LaunchListResolver: SubResolver {
        lazy var vc = { [unowned self] () -> UIViewController in
            return LaunchListVC.createVC(
                viewModel: self.vm
            )
        }()
        
        lazy var vm = { [unowned self] () -> LaunchListVM in
            return LaunchListVMImpl(logoutUC: self.resolver.logout.uc)
        }()
    }
}
