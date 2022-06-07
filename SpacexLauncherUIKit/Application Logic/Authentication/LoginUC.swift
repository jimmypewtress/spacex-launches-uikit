//
//  LoginUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

protocol LoginUC {
    func login(username: String, password: String)
}

class LoginUCImpl: LoginUC {
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func login(username: String, password: String) {
        // TODO: mock out an api call to simulate this
        self.session.userDidLogin()
    }
}
