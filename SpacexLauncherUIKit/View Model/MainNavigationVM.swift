//
//  MainNavigationVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import Combine

protocol MainNavigationVM {
    var navigationRootPublisher: Published<NavigationRoot>.Publisher { get }
}

class MainNavigationVMImpl: BaseVM, MainNavigationVM, ObservableObject {
    @Published var navigationRoot: NavigationRoot = .login
    var navigationRootPublisher: Published<NavigationRoot>.Publisher { $navigationRoot }
    
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    override func subscribe() {
        session.userStatePublisher.sink { userState in
            switch userState {
            case .loggedOut:
                self.navigationRoot = .login
            case .loggedIn:
                self.navigationRoot = .launches
                break
            }

//            UIView.transition(with: window,
//                              duration: Constants.MagicNumbers.defaultAnimationDuration,
//                              options: [.transitionCrossDissolve],
//                              animations: nil,
//                              completion: nil)

        }.store(in: &cancellables)
    }
}
