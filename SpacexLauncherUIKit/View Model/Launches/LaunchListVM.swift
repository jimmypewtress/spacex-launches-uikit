//
//  LaunchListVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation

protocol LaunchListVM {
    func logoutButtonTapped()
}

class LaunchListVMImpl: LaunchListVM {
    private let logoutUC: LogoutUC
    
    init(logoutUC: LogoutUC) {
        self.logoutUC = logoutUC
    }
    
    func logoutButtonTapped() {
        self.logoutUC.logout()
    }
}
