//
//  MainNavigationVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 10/06/2022.
//

import UIKit
import Combine

class MainNavigationVC: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    
    private var viewModel: MainNavigationVM!
    private var errorHandler: ErrorHandlerUC!
    private var alertPresenter: AlertManager!
    
    // MARK: - Constructor
    class func createVC(viewModel: MainNavigationVM,
                        errorHandler: ErrorHandlerUC,
                        alertPresenter: AlertManager) -> MainNavigationVC {
        let vc = MainNavigationVC()
        
        vc.viewModel = viewModel
        vc.errorHandler = errorHandler
        vc.alertPresenter = alertPresenter
        
        vc.didInit()
        
        return vc
    }
    
    func didInit() {
        self.viewModel.navigationRootPublisher.sink { navigationRoot in
            DispatchQueue.main.async {
                self.setRootViewController(to: navigationRoot.nvc())
            }
        }.store(in: &cancellables)
        
        self.errorHandler.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.showErrorAlert(for: error)
                    }
                }
            }.store(in: &cancellables)
    }
    
    private func setRootViewController(to vc: UINavigationController) {
        self.removeAllChildren()
        
        self.view.addSubview(vc.view)
        self.view.addSubview(vc.navigationBar)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    private func removeAllChildren() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    
    private func showErrorAlert(for error: AppError) {
        let alert = self.alertPresenter.alert(withTitle: error.title,
                                              message: error.message)
        
        alertPresenter.addAction(to: alert,
                                 withTitle: Constants.Strings.General.ok,
                                 style: .default,
                                 handler: { _ in })
        
        alertPresenter.present(alert: alert, on: self)
    }
}
