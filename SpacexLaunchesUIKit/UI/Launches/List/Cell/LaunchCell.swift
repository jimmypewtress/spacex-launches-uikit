//
//  LaunchCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Foundation

protocol LaunchCell {
    func configure(with: LaunchRow, indexPath: IndexPath)
}
