//
//  LaunchesOutput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Foundation

struct LaunchesOutput: Codable {
    var launches: [ListLaunch]
    
    private enum CodingKeys: String, CodingKey {
        case launches = "docs"
    }
}

struct ListLaunch: Codable {
    var rocket: SingleRocket
    var success: Bool?
    var date: Date
    var links: Links
    var id: String
    
    private enum CodingKeys: String, CodingKey {
        case rocket
        case success
        case date = "date_unix"
        case links
        case id
    }
}

struct SingleRocket: Codable {
    var name: String
    var description: String?
}

struct Links: Codable {
    var patch: Patch
}

struct Patch: Codable {
    var small: String?
    var large: String?
}
