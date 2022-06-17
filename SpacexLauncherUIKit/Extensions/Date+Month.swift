//
//  Date+Month.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 16/06/2022.
//

import Foundation

extension Date {
    var monthOnlyDate: Date {
        let dateComponents = Calendar.current.dateComponents([.month, .year], from: self)
        return Calendar.current.date(from: dateComponents) ?? Date(timeIntervalSince1970: 0)
    }
}
