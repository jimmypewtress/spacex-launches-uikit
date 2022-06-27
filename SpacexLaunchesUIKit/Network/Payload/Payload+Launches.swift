//
//  Payload+Launches.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

extension Payload {
    struct Launches: RequestAndResponse {
        typealias Request = LaunchesInput
        typealias Headers = Empty
        typealias Response = LaunchesOutput
        
        static func toRawRequest(_ request: Request, headers: Headers) -> RawRequest? {
            return RawRequest(request, endpoint: .launches)
        }
    }
}
