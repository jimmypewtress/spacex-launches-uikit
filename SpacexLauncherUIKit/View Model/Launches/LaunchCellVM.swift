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
    let id: String
}

extension LaunchCellVM {
    init (_ launch: ListLaunch) {
        self.rocketName = launch.rocket.name
        self.date = launch.date
        self.dateString = DateFormatter.dayMonthYear.string(from: launch.date)
        self.patchUrl = launch.links.patch.small
        self.id = launch.id
        
        if let success = launch.success {
            self.success = String(success).capitalized
        } else {
            self.success = Constants.Strings.General.unknown
        }
    }
}
