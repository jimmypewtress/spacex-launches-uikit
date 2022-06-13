//
//  LoginUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Combine

protocol LoginUC {
    var loginSuccessPublisher: Published<Bool>.Publisher { get }
    func login(email: String, password: String)
}

class LoginUCImpl: LoginUC, ObservableObject {
    @Published var loginSuccess: Bool = false
    var loginSuccessPublisher: Published<Bool>.Publisher { $loginSuccess }
    
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func login(email: String, password: String) {
        // TODO: mock out an api call to simulate this
        // TODO: handle error state
        
        self.loginSuccess = true
        
        self.session.userDidLogin()
    }
}
