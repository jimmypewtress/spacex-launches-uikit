//
//  Resolver+ActivityIndicator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import UIKit

extension Resolver {
    class ActivityIndicatorResolver: SubResolver {
        lazy var vc = { [unowned self] () -> UIViewController in
            return ActivityIndicatorVC.createVC(useCase: self.uc)
        }()
        
        lazy var uc = { [unowned self] () -> ActivityIndicatorUC in
            return singleton {
                ActivityIndicatorUCImpl()
            }
        }()
    }
}
