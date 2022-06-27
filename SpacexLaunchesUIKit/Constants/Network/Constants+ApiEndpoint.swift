//
//  Constants+ApiEndpoint.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

import Foundation

extension Constants {
    struct API {
        enum Endpoint {
            case launches
            case launch
            case launchpad
            case rocket
            
            var route: String {
                switch self {
                case .launches:
                    return "/launches/query"
                case .launch:
                    return "/launches/%@"
                case .launchpad:
                    return "/launchpads/%@"
                case .rocket:
                    return "/rockets/%@"
                }
            }
            
            var httpMethod: HTTPMethod {
                switch self {
                case .launches:
                    return .post
                default:
                    return .get
                }
            }
        }
        
        struct EndpointProperties {
            private let endpoint: Endpoint
            private let environment: Environment
            
            init(endpoint: Endpoint,
                 environment: Environment) {
                self.endpoint = endpoint
                self.environment = environment
            }
            
            var host: String? {
                return environment.host
            }
            
            var port: Int? {
                return environment.port
            }
            
            var fullPath: String {
                return (environment.basePath ?? "") + endpoint.route
            }
            
            var contentType: String? {
                switch self.endpoint {
                default: return "application/json"
                }
            }
            
            var connectionProtocol: String? {
                return environment.connectionProtocol
            }
            
            var timeoutInterval: TimeInterval {
                return 20
            }
        }
    }
}
