//
//  CustomCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit

protocol CustomCell {
    static func register(with tableView: UITableView)
    func configure(with: TableRow, indexPath: IndexPath)
}

protocol TableReferencable {
    var containingTableView: UITableView? { get set }
}

extension CustomCell {
    static func register(with tableView: UITableView) {
        let classname = String(describing: Self.self)
        let nib = UINib(nibName: classname, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: classname)
    }
}

protocol TableRow {
    var reuseIdentifier: String { get }
    var selectionStyle: UITableViewCell.SelectionStyle { get }
}
