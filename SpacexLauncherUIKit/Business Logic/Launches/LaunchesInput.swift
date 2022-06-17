//
//  LaunchesInput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

struct LaunchesInput: Codable {
    var query: LaunchesInputQuery
    var options: LaunchesInputOptions
}

struct LaunchesInputQuery: Codable {
    //  no queries
}

struct LaunchesInputOptions: Codable {
    var populate: [String] = ["rocket"]
    var sort: [String: Int] = ["date_unix": -1]
    var offset: Int
    var limit: Int
}
