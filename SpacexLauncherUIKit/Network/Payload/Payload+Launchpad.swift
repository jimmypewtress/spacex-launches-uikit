//
//  Payload+Launchpad.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 23/06/2022.
//

extension Payload {
    struct Launchpad: RequestAndResponse {
        typealias Request = IdOnlyInput
        typealias Headers = Empty
        typealias Response = SingleLaunchPad
        
        static func toRawRequest(_ request: Request, headers: Headers) -> RawRequest? {
            return RawRequest(request,
                              endpointParams: request.endpointParams,
                              endpoint: .launchpad)
        }
    }
}
