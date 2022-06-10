//
//  General.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

enum NavigationRoot {
    case login
    case launches
    
    func coordinator(navigationContoroller: UINavigationController?) -> NavigationCoordinator {
        switch self {
        case .login:
            return LoginCoordinator(navigationViewController: navigationContoroller)
        case .launches:
            return LaunchListCoordinator(navigationViewController: navigationContoroller)
        }
    }
    
    func vc() -> UIViewController {
        let nvc = UINavigationController()
        
        switch self {
        case .login:
            nvc.setNavigationBarHidden(true, animated: false)
        default:
            break
        }
        
        let coordinator = self.coordinator(navigationContoroller: nvc)
        coordinator.start()
        
        return nvc
    }
}
