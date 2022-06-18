//
//  Resolver.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

extension Resolver {
    class EnvironmentResolver: SubResolver {
        lazy var env = { [unowned self] () -> Environment in
            return singleton {
                EnvironmentImpl()
            }
        }()
    }
}
