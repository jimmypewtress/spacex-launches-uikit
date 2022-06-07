//
//  LoginVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

protocol LoginVM {
    func loginButtonTapped()
}

class LoginVMImpl: LoginVM {
    private let uc: LoginUC
    
    init(uc: LoginUC) {
        self.uc = uc
    }
    
    func loginButtonTapped() {
        self.uc.login(username: "", password: "")
    }
}
