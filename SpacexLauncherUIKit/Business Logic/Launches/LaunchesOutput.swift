//
//  LaunchesOutput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Foundation

struct LaunchesOutput: Codable {
    var launches: [Launch]
    
    private enum CodingKeys: String, CodingKey {
        case launches = "docs"
    }
}

struct Launch: Codable {
    var rocket: Rocket
    var success: Bool
    var date: Date
    var links: Links
    
    private enum CodingKeys: String, CodingKey {
        case rocket
        case success
        case date = "date_unix"
        case links
    }
}

struct Rocket: Codable {
    var name: String
}

struct Links: Codable {
    var patch: Patch
}

struct Patch: Codable {
    var small: String?
    var large: String?
}
