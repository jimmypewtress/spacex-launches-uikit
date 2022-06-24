//
//  SpacerCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

class SpacerCell: UITableViewCell, CustomCell {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    func configure(with row: TableRow, indexPath: IndexPath) {
        if let row = row as? DetailRow, case .spacer(let model) = row {
            self.heightConstraint.constant = CGFloat(model.height)
        }
    }
}
