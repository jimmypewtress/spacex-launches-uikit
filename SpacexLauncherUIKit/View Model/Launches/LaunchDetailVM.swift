//
//  LaunchDetailVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

protocol LaunchDetailVM {
    
}

class LaunchDetailVMImpl: LaunchDetailVM {
    private var uc: LaunchDetailUC
    private var backCoordinator: NavigationCoordinator
    
    init(uc: LaunchDetailUC,
         backCoordinator: NavigationCoordinator) {
        self.uc = uc
        self.backCoordinator = backCoordinator
    }
}
