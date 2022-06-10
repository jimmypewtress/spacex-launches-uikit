//
//  ForgotPasswordVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

protocol ForgotPasswordVM {
    func cancelButtonTapped()
}

class ForgotPasswordVMImpl: ForgotPasswordVM {
    private let uc: ForgotPasswordUC
    private let dismissModalCoordinator: NavigationCoordinator
    
    init(uc: ForgotPasswordUC,
         dismissModalCoordinator: NavigationCoordinator) {
        self.uc = uc
        self.dismissModalCoordinator = dismissModalCoordinator
    }
    
    func cancelButtonTapped() {
        self.dismissModalCoordinator.start()
    }
}
