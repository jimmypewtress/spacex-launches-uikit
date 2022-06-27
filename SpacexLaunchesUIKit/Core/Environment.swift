//
//  Environment.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation

enum PlistKey: String {
    case environmentName = "environment_name"
    case host = "host"
    case port = "port"
    case basePath = "base_path"
    case connectionProtocol = "connection_protocol"
    case flags = "FLAGS"
}

protocol Environment {
    var environmentName: String { get }
    var host: String? { get }
    var port: Int? { get }
    var basePath: String? { get }
    var connectionProtocol: String? { get }
    var flags: String? { get }
}

struct EnvironmentImpl: Environment {
    private var infoDict: [String: Any] {
        return Bundle.main.infoDictionary ?? [:]
    }
    
    var environmentName: String {
        return infoDict[PlistKey.environmentName.rawValue] as? String ?? "Unknown"
    }
    
    var host: String? {
        return infoDict[PlistKey.host.rawValue] as? String
    }
    
    var port: Int? {
        return Int(infoDict[PlistKey.port.rawValue] as? String ?? "")
    }
    
    var basePath: String? {
        return infoDict[PlistKey.basePath.rawValue] as? String
    }
    
    var connectionProtocol: String? {
        return infoDict[PlistKey.connectionProtocol.rawValue] as? String
    }
    
    var flags: String? {
        return infoDict[PlistKey.flags.rawValue] as? String
    }
}
