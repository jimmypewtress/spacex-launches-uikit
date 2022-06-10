//
//  LoginCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

class LoginCoordinator: NavigationCoordinator {
    override func onStart(_ obj: Void, r: Resolver = Resolver()) {
        let vc = r.login.vc
        
        self.navigationViewController?.pushViewController(vc, animated: false)
    }
}
