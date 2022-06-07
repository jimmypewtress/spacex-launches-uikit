//
//  SubResolver.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

extension Resolver {
    class SubResolver {
        unowned var resolver: Resolver
        
        init(resolver: Resolver) {
            self.resolver = resolver
        }
    }
}
