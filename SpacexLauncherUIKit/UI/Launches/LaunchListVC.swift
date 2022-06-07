//
//  LaunchListVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

class LaunchListVC: UIViewController {
    private var viewModel: LaunchListVM!
    
    // MARK: - Constructor
    class func createVC(viewModel: LaunchListVM) -> LaunchListVC {
        return Utils.createVC(storyboard: .launchList) { vc in
            vc.viewModel = viewModel
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.viewModel.logoutButtonTapped()
    }
}
