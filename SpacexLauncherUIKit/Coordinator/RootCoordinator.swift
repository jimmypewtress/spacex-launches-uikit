//
//  RootCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

class RootCoordinator: Coordinator {
    static let shared = RootCoordinator()
    
    let mainNavigation = MainNavigationCoordinator()
    let activityIndicator = ActivityIndicatorCoordinator()
    
    func start() {
        let r = Resolver()
        
        let session = r.session.uc
        session.checkUserState()
        
        self.mainNavigation.start()
        self.activityIndicator.start()
    }
}
