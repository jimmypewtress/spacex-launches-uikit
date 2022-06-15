//
//  LaunchDetailCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import UIKit

class LaunchDetailCell: UITableViewCell, LaunchCell {
    @IBOutlet weak var rocketLabel: StyledLabel!
    @IBOutlet weak var successLabel: StyledLabel!
    @IBOutlet weak var successValueLabel: StyledLabel!
    @IBOutlet weak var dateLabel: StyledLabel!
    @IBOutlet weak var dateValueLabel: StyledLabel!
    @IBOutlet weak var patchImageView: UIImageView!
    
    private let strings = Constants.Strings.Launches.DetailCell.self
    
    func configure(with row: LaunchRow, indexPath: IndexPath) {
        if case .cell(let launch) = row {
            self.rocketLabel.text = launch.rocketName
            self.successLabel.text = strings.success + ":"
            self.successValueLabel.text = launch.success
            self.dateLabel.text = strings.date + ":"
            self.dateValueLabel.text = launch.date
        }
    }
}
