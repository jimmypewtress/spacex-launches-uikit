//
//  MockedLoginUC.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

@testable import SpacexLauncherUIKit
import Combine

class MockedLoginUC: LoginUC {
    @Published var loginSuccess: Bool = false
    var loginSuccessPublisher: Published<Bool>.Publisher { $loginSuccess }
    
    var email: String?
    var password: String?
    var shouldLoginSuccessfully: Bool?
    
    func login(email: String, password: String) {
        self.email = email
        self.password = password
        
        self.loginSuccess = self.shouldLoginSuccessfully ?? false
    }
}
