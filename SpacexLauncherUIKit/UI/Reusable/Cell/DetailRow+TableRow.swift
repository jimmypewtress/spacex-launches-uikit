//
//  DetailRow+TableRow.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

extension DetailRow: TableRow {
    var reuseIdentifier: String {
        switch self {
        case .image:
            return Constants.DetailCells.Image.reuseIdentifier
        case .heading:
            return Constants.DetailCells.Heading.reuseIdentifier
        case .info:
            return Constants.DetailCells.Info.reuseIdentifier
        case .text:
            return Constants.DetailCells.Text.reuseIdentifier
        case .spacer:
            return Constants.DetailCells.Spacer.reuseIdentifier
        case .button:
            return Constants.DetailCells.Button.reuseIdentifier
        }
    }
    
    var selectionStyle: UITableViewCell.SelectionStyle {
        switch self {
        case .button:
            return .default
        default:
            return .none
        }
    }
}
