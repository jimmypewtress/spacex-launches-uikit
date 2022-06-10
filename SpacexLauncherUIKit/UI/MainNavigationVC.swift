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
    
    // MARK: - Constructor
    class func createVC(viewModel: MainNavigationVM) -> MainNavigationVC {
        let vc = MainNavigationVC()
        vc.viewModel = viewModel
        vc.didInit()
        
        return vc
    }
    
    func didInit() {
        self.viewModel.navigationRootPublisher.sink { navigationRoot in
            self.setRootViewController(to: navigationRoot.vc())
        }.store(in: &cancellables)
    }
    
    private func setRootViewController(to vc : UIViewController) {
        self.removeAllChildren()
        
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func removeAllChildren() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
}
