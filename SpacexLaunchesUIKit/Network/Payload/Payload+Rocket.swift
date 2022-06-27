//
//  Payload+Rocket.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 23/06/2022.
//

extension Payload {
    struct Rocket: RequestAndResponse {
        typealias Request = IdOnlyInput
        typealias Headers = Empty
        typealias Response = SingleRocket
        
        static func toRawRequest(_ request: Request, headers: Headers) -> RawRequest? {
            return RawRequest(request,
                              endpointParams: request.endpointParams,
                              endpoint: .rocket)
        }
    }
}
