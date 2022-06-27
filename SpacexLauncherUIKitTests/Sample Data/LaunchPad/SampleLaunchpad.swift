//
//  SampleLaunchpad.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 27/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

extension Sample {
    class SampleLaunchpad: NSObject {
        lazy var launchpadData: Data? = readFile(fileName: "SampleLaunchpad").data(using: .utf8)
    }
}
