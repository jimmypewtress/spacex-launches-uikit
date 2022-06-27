//
//  ExternalUrlCoordinator.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

class ExternalUrlCoordinator: CoordinatorImpl<String> {
    override func onStart(_ obj: String, r: Resolver = Resolver()) {
        if let url = URL(string: obj) {
            UIApplication.shared.open(url)
        }
    }
}
