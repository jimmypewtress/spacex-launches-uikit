//
//  LoginVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

protocol LoginVM {
    func login()
}

class LoginVMImpl: LoginVM {
    func login() {
        print("login called")
    }
}
