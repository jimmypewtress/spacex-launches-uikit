//
//  DismissModalCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit

class DismissModalCoordinator: NavigationCoordinator {
    override func onStart(_ obj: Void, r: Resolver = Resolver()) {
        self.navigationViewController?.dismiss(animated: true)
    }
}
