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
    
    // MARK: - General
    lazy var session = SessionResolver(resolver: self)
}
