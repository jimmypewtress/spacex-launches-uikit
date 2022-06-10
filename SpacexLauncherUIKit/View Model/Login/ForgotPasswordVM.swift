//
//  ForgotPasswordVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

protocol ForgotPasswordVM {
    
}

class ForgotPasswordVMImpl: ForgotPasswordVM {
    private let uc: ForgotPasswordUC
    
    init(uc: ForgotPasswordUC) {
        self.uc = uc
    }
}
