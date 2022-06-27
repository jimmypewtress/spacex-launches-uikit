//
//  ErrorHandlerUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import Combine

protocol ErrorHandlerUC {
    var errorSubject: CurrentValueSubject<AppError?, Error> { get }
    
    func showError(_ error: AppError)
}

class ErrorHandlerUCImpl: ErrorHandlerUC {
    var errorSubject = CurrentValueSubject<AppError?, Error>(nil)
    
    func showError(_ error: AppError) {
        self.errorSubject.send(error)
    }
}
