//
//  ButtonCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

class ButtonCell: UITableViewCell, CustomCell {
    @IBOutlet weak var button: StyledButton!
    
    func configure(with row: TableRow, indexPath: IndexPath) {
        if let row = row as? DetailRow, case .button(let model) = row {
            self.button.isUserInteractionEnabled = false
            self.button.setTitle(model.title, for: .normal)
            self.button.isEnabled = model.enabled
        }
    }
}
