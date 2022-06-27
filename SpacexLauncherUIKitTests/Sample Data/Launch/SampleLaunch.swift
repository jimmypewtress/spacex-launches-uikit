//
//  SampleLaunch.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 27/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

extension Sample {
    class SampleLaunch: NSObject {
        lazy var launchData: Data? = readFile(fileName: "SampleLaunch").data(using: .utf8)
    }
}
