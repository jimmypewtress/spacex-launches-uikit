//
//  Constants+Error.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

extension Constants {
    struct Error {
        enum Network {
            case noHostForEndpoint
            case cannotCreateUrl
            case noHttpResponse
            case serializationIssue
            case jsonInvalidIssue
            case deserializationIssue
        }
    }
}
