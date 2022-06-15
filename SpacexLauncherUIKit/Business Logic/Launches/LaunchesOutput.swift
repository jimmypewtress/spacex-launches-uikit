//
//  LaunchesOutput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

struct LaunchesOutput: Codable {
    var launches: [Launch]
    
    private enum CodingKeys: String, CodingKey {
        case launches = "docs"
    }
}

struct Launch: Codable {
    var details: String?
}
