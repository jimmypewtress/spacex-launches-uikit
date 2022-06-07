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
    lazy var launchList = LaunchListResolver(resolver: self)
    
    // MARK: - General
    lazy var session = SessionResolver(resolver: self)
}
