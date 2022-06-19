//
//  SampleLaunch.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

extension Sample {
    class SampleLaunch: NSObject {
        lazy var launchesJson = readFile(fileName: "SampleLaunches")
        lazy var launchesList: LaunchesOutput? = launchesJson.decode()
        lazy var launchesSingle: Launch? = self.launchesList?.launches.first
        lazy var launchesData: Data? = readFile(fileName: "SampleLaunches").data(using: .utf8)
    }
}
