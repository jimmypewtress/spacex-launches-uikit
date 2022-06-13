//
//  Resolver+AlertManager.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

extension Resolver {
    class AlertPresenterResolver: SubResolver {
        lazy var manager = { [unowned self] () -> AlertManager in
            return AlertManagerImpl()
        }()
    }
}
