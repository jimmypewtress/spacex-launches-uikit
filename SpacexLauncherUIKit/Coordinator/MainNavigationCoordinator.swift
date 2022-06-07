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
                // TODO: show lauch list view
                break
            }
        }.store(in: &cancellables)
    }
}
