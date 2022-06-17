//
//  AppError.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

struct AppError {
    let title: String
    let message: String
    
    init(title: String,
         message: String) {
        self.title = title
        self.message = message
    }
    
    func show() {
        Global.shared.errorHandler.showError(self)
    }
}
