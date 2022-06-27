//
//  LaunchOutput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 20/06/2022.
//

import Foundation

struct SingleLaunch: Codable {
    var rocketId: String
    var date: Date
    var links: Links
    var launchpadId: String
    
    private enum CodingKeys: String, CodingKey {
        case rocketId = "rocket"
        case date = "date_unix"
        case links
        case launchpadId = "launchpad"
    }
}
