//
//  DateFormatterTests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 19/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class DateFormatterTests: TestCase {
    
    let june1st2022 = Date(timeIntervalSince1970: 1654084800)
    let june19th2022 = Date(timeIntervalSince1970: 1655640000)
    
    func testDayMonthYearDayInSingleDigits() {
        let dateString = DateFormatter.dayMonthYear.string(from: june1st2022)
        
        XCTAssertNotNil(dateString)
        XCTAssertEqual(dateString, "1 June 2022")
    }

    func testDayMonthYearDayInMultipleDigits() {
        let dateString = DateFormatter.dayMonthYear.string(from: june19th2022)
        
        XCTAssertNotNil(dateString)
        XCTAssertEqual(dateString, "19 June 2022")
    }
    
    func testMonthYear() {
        let dateString = DateFormatter.monthYear.string(from: june19th2022)
        
        XCTAssertNotNil(dateString)
        XCTAssertEqual(dateString, "June 2022")
    }
    
    func testMonthOnlyThreeLetters() {
        let dateString = DateFormatter.monthOnlyThreeLetters.string(from: june19th2022)
        
        XCTAssertNotNil(dateString)
        XCTAssertEqual(dateString, "Jun")
    }
    
    func testYearOnly() {
        let dateString = DateFormatter.yearOnly.string(from: june19th2022)
        
        XCTAssertNotNil(dateString)
        XCTAssertEqual(dateString, "2022")
    }

}
