//
//  Resolver+LaunchList.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

extension Resolver {
    class LaunchListResolver: SubResolver {
        struct Input {
            var detailCoordinator: NavigationCoordinatorOf<LaunchDetailVMInput>
        }
        
        var input: Input!
        
        lazy var vc = { [unowned self] () -> UIViewController in
            return LaunchListVC.createVC(viewModel: self.vm)
        }()
        
        lazy var vm = { [unowned self] () -> LaunchListVM in
            return LaunchListVMImpl(uc: self.uc,
                                    logoutUC: self.resolver.logout.uc,
                                    detailCoordinator: input.detailCoordinator)
        }()
        
        lazy var uc = { [unowned self] () -> LaunchListUC in
            return LaunchListUCImpl(launchesRequest: self.resolver.api.launches)
        }()
    }
}
