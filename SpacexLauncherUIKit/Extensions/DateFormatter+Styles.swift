//
//  DateFormatter+Styles.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 16/06/2022.
//

import Foundation

extension DateFormatter {
    static let dayMonthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }()
    
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }()
    
    static let monthOnlyThreeLetters: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }()
    
    static let yearOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }()
}
