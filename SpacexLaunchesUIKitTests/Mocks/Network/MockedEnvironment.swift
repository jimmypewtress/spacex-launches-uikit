//
//  MockedEnvironment.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

struct MockedEnvironment: Environment {
    var environmentName: String = "env"
    var host: String?
    var port: Int?
    var basePath: String?
    var connectionProtocol: String?
    var flags: String?
}
