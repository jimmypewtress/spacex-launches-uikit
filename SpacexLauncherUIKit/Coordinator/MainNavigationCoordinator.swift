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
    
    override func onStart(_ obj: Void, r: Resolver) {
        guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else { return }
        
        let session = r.session.uc
        
        session.userStatePublisher.sink { userState in
            switch userState {
            case .loggedOut:
                window.rootViewController = r.login.vc
            case .loggedIn:
                window.rootViewController = r.launchList.vc
                break
            }
            
            UIView.transition(with: window,
                              duration: Constants.MagicNumbers.defaultAnimationDuration,
                              options: [.transitionCrossDissolve],
                              animations: nil,
                              completion: nil)
            
        }.store(in: &cancellables)
    }
}
