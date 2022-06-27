//
//  HeadingCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

class HeadingCell: UITableViewCell, CustomCell {
    @IBOutlet weak var headingLabel: StyledLabel!
    
    class func register(with tableView: UITableView) {
        let nib = UINib(nibName: Constants.DetailCells.Heading.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.DetailCells.Heading.reuseIdentifier)
    }
    
    func configure(with row: TableRow, indexPath: IndexPath) {
        if let row = row as? DetailRow, case .heading(let model) = row {
            self.headingLabel.text = model.heading
        }
    }
}
