//
//  ForgotPasswordUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import Combine

protocol ForgotPasswordUC {
    var requestLinkLinkSuccessPublisher: Published<Bool>.Publisher { get }
    func requestLink(email: String)
}

class ForgotPasswordUCImpl: ForgotPasswordUC {
    @Published var requestLinkSuccess: Bool = false
    var requestLinkLinkSuccessPublisher: Published<Bool>.Publisher { $requestLinkSuccess }
    
    func requestLink(email: String) {
        // TODO: mock out an api call to simulate this
        // TODO: handle error state
        
        self.requestLinkSuccess = true
    }
}
