//
//  Resolver+Logout.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

extension Resolver {
    class LogoutResolver: SubResolver {
        lazy var uc = { [unowned self] () -> LogoutUC in
            return LogoutUCImpl(session: self.resolver.session.uc)
        }()
    }
}
