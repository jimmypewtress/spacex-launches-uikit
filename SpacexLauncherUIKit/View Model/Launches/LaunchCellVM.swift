//
//  LaunchCellVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Foundation

struct LaunchCellVM: Equatable {
    let rocketName: String
    let success: String
    let date: Date
    let dateString: String
    let patchUrl: String?
}

extension LaunchCellVM {
    init (_ launch: Launch) {
        self.rocketName = launch.rocket.name
        self.date = launch.date
        self.dateString = DateFormatter.dayMonthYear.string(from: launch.date)
        self.patchUrl = launch.links.patch.small
        
        if let success = launch.success {
            self.success = String(success)
        } else {
            self.success = Constants.Strings.General.unknown
        }
    }
}
