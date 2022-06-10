//
//  BaseNavigationCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

typealias NavigationCoordinator = NavigationCoordinatorOf<Void>

class NavigationCoordinatorOf<Type>: CoordinatorImpl<Type> {
    // MARK: inputs
    weak var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController?) {
        self.navigationViewController = navigationViewController
    }
}
