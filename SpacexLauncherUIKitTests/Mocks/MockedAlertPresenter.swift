//
//  MockedAlertManager.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

import UIKit
@testable import SpacexLauncherUIKit

class MockedAlertManager: AlertManager {
    var alertWasCreated = false
    var alertTitle: String!
    var alertMessage: String!
    var actions: [AlertHandler] = []
    
    func alert(withTitle title: String, message: String) -> UIAlertController {
        self.alertWasCreated = true
        self.alertTitle = title
        self.alertMessage = message
        
        return UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
    }
    
    func addAction(to alert: UIAlertController, withTitle title: String, style: UIAlertAction.Style, handler: @escaping AlertHandler) {
        self.actions.append(handler)
    }
    
    func present(alert: UIAlertController, on controller: UIViewController?) { }
}
