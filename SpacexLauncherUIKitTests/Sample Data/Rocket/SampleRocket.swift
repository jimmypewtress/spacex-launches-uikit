//
//  SampleRocket.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 27/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

extension Sample {
    class SampleRocket: NSObject {
        lazy var rocketData: Data? = readFile(fileName: "SampleRocket").data(using: .utf8)
        lazy var rocketDataNoDescrption: Data? = readFile(fileName: "SampleRocketNoDescription").data(using: .utf8)
    }
}
