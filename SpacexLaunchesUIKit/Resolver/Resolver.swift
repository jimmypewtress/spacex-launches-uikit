//
//  Resolver.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation

class Resolver {
    // MARK: - Views
    lazy var login = LoginResolver(resolver: self)
    lazy var logout = LogoutResolver(resolver: self)
    lazy var forgotPassword = ForgotPasswordResolver(resolver: self)
    lazy var launchList = LaunchListResolver(resolver: self)
    lazy var launchDetail = LaunchDetailResolver(resolver: self)
    
    // MARK: - General
    lazy var mainNavigation = MainNavigationResolver(resolver: self)
    lazy var session = SessionResolver(resolver: self)
    lazy var alert = AlertPresenterResolver(resolver: self)
    lazy var environment = EnvironmentResolver(resolver: self)
    lazy var activityIndicator = ActivityIndicatorResolver(resolver: self)
    lazy var errorHandler = ErrorHandlerResolver(resolver: self)
    
    // MARK: - Network
    lazy var api = APIResolver(resolver: self)
}
