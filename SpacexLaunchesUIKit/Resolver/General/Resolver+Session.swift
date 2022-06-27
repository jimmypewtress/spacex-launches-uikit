//
//  Resolver+Session.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

extension Resolver {
    class SessionResolver: SubResolver {
        lazy var uc = { [unowned self] () -> Session in
            return singleton {
                SessionImpl()
            }
        }()
    }
}
