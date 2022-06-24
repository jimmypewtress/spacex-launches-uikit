//
//  TextCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

class TextCell: UITableViewCell, CustomCell {
    @IBOutlet weak var contentLabel: StyledLabel!
    
    func configure(with row: TableRow, indexPath: IndexPath) {
        if let row = row as? DetailRow, case .text(let model) = row {
            self.contentLabel.text = model.text
        }
    }
}
