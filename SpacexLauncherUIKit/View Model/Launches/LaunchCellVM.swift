//
//  LaunchCellVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Foundation

struct LaunchCellVM {
    let rocketName: String
    let success: String
    let date: String
    let patchUrl: String?
}

extension LaunchCellVM {
    init (_ launch: Launch) {
        self.rocketName = launch.rocket.name
        self.success = String(launch.success)
        self.date = "Date here"
        self.patchUrl = launch.links.patch.small
    }
}
