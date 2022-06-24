//
//  Payload+Launch.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 20/06/2022.
//

extension Payload {
    struct Launch: RequestAndResponse {
        typealias Request = IdOnlyInput
        typealias Headers = Empty
        typealias Response = SingleLaunch
        
        static func toRawRequest(_ request: Request, headers: Headers) -> RawRequest? {
            return RawRequest(request,
                              endpointParams: request.endpointParams,
                              endpoint: .launch)
        }
    }
}
