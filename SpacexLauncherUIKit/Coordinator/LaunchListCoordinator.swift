//
//  LaunchListCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

class LaunchListCoordinator: NavigationCoordinator {
    override func onStart(_ obj: Void, r: Resolver = Resolver()) {
        let vc = r.launchList.vc
        
        self.navigationViewController?.pushViewController(vc, animated: false)
    }
}
