//
//  MockedForgotPasswordUC.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

@testable import SpacexLauncherUIKit
import Combine

class MockedForgotPasswordUC: ForgotPasswordUC {
    @Published var requestLinkSuccess: Bool = false
    var requestLinkSuccessPublisher: Published<Bool>.Publisher { $requestLinkSuccess }
    
    var requestedEmail: String?
    var shouldReturnSuccess: Bool?
    
    func requestLink(email: String) {
        self.requestedEmail = email
        
        self.requestLinkSuccess = shouldReturnSuccess ?? false
    }
}
