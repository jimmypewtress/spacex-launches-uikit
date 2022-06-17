//
//  Resolver+API.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

extension Resolver {
    class APIResolver: SubResolver {
        lazy var network = { [unowned self] () -> RawNetwork in
            return singleton {
                RawNetworkImpl(environment: self.resolver.environment.env)
            }
        }()
        
        func request<Type>() -> ApiRequest<Type> {
            let apiRequest = ApiRequest<Type>(network: self.network,
                                              activityIndicator: self.resolver.activityIndicator.uc)
            
            
            return apiRequest
        }
        
        lazy var launches = { [unowned self] () -> ApiRequest<Payload.Launches> in
            return self.request()
        }()
    }
}
