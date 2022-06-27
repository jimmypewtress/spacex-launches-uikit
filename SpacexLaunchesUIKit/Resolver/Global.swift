//
//  Global.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import Foundation

class Global: NSObject {
    static var shared = Global()

    let errorHandler: ErrorHandlerUC

    override init() {
        let resolver = Resolver()
        
        self.errorHandler = resolver.errorHandler.uc
    }
}

