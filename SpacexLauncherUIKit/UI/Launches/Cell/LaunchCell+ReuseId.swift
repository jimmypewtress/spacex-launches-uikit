//
//  LaunchCell+ReuseId.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

extension LaunchRow {
    var reuseIdentifier: String {
        switch self {
        case .cell:
            return Constants.Launches.ReuseIdentifiers.launchDetail
        default:
            return Constants.Launches.ReuseIdentifiers.spinner
        }
    }
}
