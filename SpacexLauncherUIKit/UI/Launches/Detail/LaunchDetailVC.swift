//
//  LaunchDetailVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import UIKit

class LaunchDetailVC: BaseVC {
    private var viewModel: LaunchDetailVM!
    
    // MARK: - Constructor
    class func createVC(viewModel: LaunchDetailVM) -> LaunchDetailVC {
        return Utils.createVC(storyboard: .launchDetail) { vc in
            vc.viewModel = viewModel
        }
    }
}
