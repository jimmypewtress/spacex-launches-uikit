//
//  LaunchSpinnerCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import UIKit

class LaunchSpinnerCell: UITableViewCell, LaunchCell {
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    func configure(with: LaunchRow, indexPath: IndexPath) {
        self.spinner.startAnimating()
    }
}
