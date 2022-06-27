//
//  MainNavigationCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation
import Combine
import UIKit

class MainNavigationCoordinator: CoordinatorImpl<Void> {
    private var cancellables: Set<AnyCancellable> = []
    private weak var loginViewConroller: UIViewController?
    
    override func onStart(_ obj: Void, r: Resolver) {
        guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else { return }
        
        window.rootViewController = r.mainNavigation.vc
    }
}
