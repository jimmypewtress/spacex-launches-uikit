//
//  AlertPresenter.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

import UIKit

typealias AlertHandler = ((UIAlertAction) -> Void)

protocol AlertManager {
    func alert(withTitle title: String, message: String) -> UIAlertController
    func addAction(to alert: UIAlertController, withTitle title: String, style: UIAlertAction.Style, handler: @escaping AlertHandler)
    func present(alert: UIAlertController, on controller: UIViewController?)
}

class AlertManagerImpl: AlertManager {
    private var actionHandlers: [UIAlertAction: AlertHandler] = [:]
    
    func alert(withTitle title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
    }
    
    func addAction(to alert: UIAlertController,
                   withTitle title: String,
                   style: UIAlertAction.Style,
                   handler: @escaping AlertHandler) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        alert.addAction(action)
    }
    
    func present(alert: UIAlertController, on controller: UIViewController?) {
        controller?.present(alert, animated: false, completion: nil)
    }
}
