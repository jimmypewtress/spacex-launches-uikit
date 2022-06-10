//
//  ForgotPasswordCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

class ForgotPasswordCoorindator: CoordinatorImpl<Void> {
    weak var loginViewController: UIViewController?
    
    init(loginViewController: UIViewController?) {
        self.loginViewController = loginViewController
    }
    
    override func onStart(_ obj: Void, r: Resolver = Resolver()) {
        let vc = r.forgotPassword.vc
        
        self.loginViewController?.present(vc, animated: true)
    }
}
