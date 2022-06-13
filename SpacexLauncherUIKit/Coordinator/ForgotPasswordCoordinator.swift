//
//  ForgotPasswordCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

class ForgotPasswordCoorindator: NavigationCoordinator {
    override func onStart(_ obj: Void, r: Resolver = Resolver()) {
        r.forgotPassword.input = .init(dismissModalCoordinator: DismissModalCoordinator(navigationViewController: self.navigationViewController))
        
        let vc = r.forgotPassword.vc
        
        self.navigationViewController?.present(vc, animated: true)
    }
}
