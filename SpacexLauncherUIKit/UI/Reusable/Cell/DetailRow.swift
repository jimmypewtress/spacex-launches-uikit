//
//  DetailRow.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

enum DetailRow {
    case image(_ cell: ImageCellVM)
    case heading(_ cell: HeadingCellVM)
    case info(_ cell: InfoCellVM)
    case text(_ cell: TextCellVM)
    case spacer(_ cell: SpacerCellVM)
}
