//
//  InfoCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

class InfoCell: UITableViewCell, CustomCell {
    @IBOutlet weak var headingLabel: StyledLabel!
    @IBOutlet weak var infoLabel: StyledLabel!
    
    func configure(with row: TableRow, indexPath: IndexPath) {
        if let row = row as? DetailRow, case .info(let model) = row {
            self.headingLabel.text = model.heading
            self.infoLabel.text = model.text
        }
    }
}
