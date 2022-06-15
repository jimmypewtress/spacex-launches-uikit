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

class LaunchListVMImpl: BaseVM, LaunchListVM {
    private let uc: LaunchListUC
    private let logoutUC: LogoutUC
    
    init(uc: LaunchListUC,
         logoutUC: LogoutUC) {
        self.uc = uc
        self.logoutUC = logoutUC
        
        super.init()
        
        self.fetchData()
    }
    
    private func fetchData() {
        self.uc.fetchLaunches()
    }
    
    func logoutButtonTapped() {
        self.logoutUC.logout()
    }
}
