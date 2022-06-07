//
//  Session.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation

enum UserState {
    case loggedOut
    case loggedIn
}

protocol Session {
    var userState: UserState { get }
    var userStatePublisher: Published<UserState>.Publisher { get }
    
    func login()
    func logout()
    func checkUserState()
}

class SessionImpl: Session, ObservableObject {
    @Published var userState: UserState
    var userStatePublisher: Published<UserState>.Publisher { $userState }
    
    @Persisted(key: Constants.User.userIsLoggedInDefaultsKey, defaultValue: false)
    private var userIsLoggedIn: Bool
    
    init(userState: UserState = .loggedOut) {
        self.userState = userState
    }
    
    func login() {
        self.userState = .loggedIn
        self.userIsLoggedIn = true
    }
    
    func logout() {
        self.userState = .loggedOut
        self.userIsLoggedIn = false
    }
    
    func checkUserState() {
        self.userState = self.userIsLoggedIn ? .loggedIn : .loggedOut
    }
}
