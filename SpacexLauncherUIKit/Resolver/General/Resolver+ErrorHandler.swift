//
//  Resolver+ErrorHandler.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

extension Resolver {
    class ErrorHandlerResolver: SubResolver {
        lazy var uc = { [unowned self] () -> ErrorHandlerUC in
            return singleton {
                ErrorHandlerUCImpl()
            }
        }()
    }
}
