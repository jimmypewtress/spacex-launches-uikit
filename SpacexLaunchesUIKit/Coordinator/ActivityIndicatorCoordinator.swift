//
//  ActivityIndicatorCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import UIKit

class ActivityIndicatorCoordinator: CoordinatorImpl<Void> {
    private var window: PassthroughWindow?
    
    override func onStart(_ obj: Void, r: Resolver) {
        let windowScene = UIApplication.shared
                        .connectedScenes
                        .first
        
        if let windowScene = windowScene as? UIWindowScene {
            self.window = PassthroughWindow(windowScene: windowScene, boolPublisher: r.activityIndicator.uc.isShownPublisher)
            self.window?.rootViewController = r.activityIndicator.vc
            self.window?.windowLevel = .alert
            self.window?.isHidden = false
        }
    }
}
