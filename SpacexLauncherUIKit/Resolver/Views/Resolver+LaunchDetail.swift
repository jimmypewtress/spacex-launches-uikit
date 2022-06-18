//
//  Resolver+LaunchDetail.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import UIKit

extension Resolver {
    class LaunchDetailResolver: SubResolver {
        struct Input {
            var input: LaunchDetailVMInput!
            var backCoordinator: NavigationCoordinator!
        }
        
        var input: Input!
        
        lazy var vc = { [unowned self] () -> UIViewController in
            return LaunchDetailVC.createVC(viewModel: self.vm)
        }()
        
        lazy var vm = { [unowned self] () -> LaunchDetailVM in
            return LaunchDetailVMImpl(uc: self.uc, backCoordinator: input.backCoordinator)
        }()
        
        lazy var uc = { [unowned self] () -> LaunchDetailUC in
            return LaunchDetailUCImpl()
        }()
    }
}
