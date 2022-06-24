//
//  LaunchDetailCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

class LaunchDetailCoordinator: NavigationCoordinatorOf<LaunchDetailVMInput> {
    override func onStart(_ obj: LaunchDetailVMInput, r: Resolver = Resolver()) {
        r.launchDetail.input = .init(input: obj)
        
        let vc = r.launchDetail.vc
        
        self.navigationViewController?.pushViewController(vc, animated: false)
    }
}
