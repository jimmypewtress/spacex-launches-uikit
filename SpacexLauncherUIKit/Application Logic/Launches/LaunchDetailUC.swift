//
//  LaunchDetailUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import Combine

protocol LaunchDetailUC {
    var combinedLaunchPublisher: Published<CombinedLaunch?>.Publisher { get }
    func fetchLaunchDeatails(launchId: String)
}

class LaunchDetailUCImpl: BaseUC, LaunchDetailUC, ObservableObject {
    @Published var combinedLaunch: CombinedLaunch? = nil
    var combinedLaunchPublisher: Published<CombinedLaunch?>.Publisher { $combinedLaunch }
    
    private let launchRequest: ApiRequest<Payload.Launch>
    private let launchpadRequest: ApiRequest<Payload.Launchpad>
    private let rocketRequest: ApiRequest<Payload.Rocket>
    
    init(launchRequest: ApiRequest<Payload.Launch>,
         launchpadRequest: ApiRequest<Payload.Launchpad>,
         rocketRequest: ApiRequest<Payload.Rocket>) {
        self.launchRequest = launchRequest
        self.launchpadRequest = launchpadRequest
        self.rocketRequest = rocketRequest
    }
    
    func fetchLaunchDeatails(launchId: String) {
        let launchInput = Payload.Launch.Request(id: launchId)
        let headers = Payload.Empty()
        
        self.launchRequest.fetch(launchInput, headers: headers, showSpinner: true).flatMap{ launchResponse -> AnyPublisher<CombinedLaunch, APIRequestError> in
            let launchPadInput = Payload.Launchpad.Request(id: launchResponse.launchpadId)
            let rocketInput = Payload.Rocket.Request(id: launchResponse.rocketId)

            return Publishers.Zip(self.launchpadRequest.fetch(launchPadInput, headers: headers),
                                  self.rocketRequest.fetch(rocketInput, headers: headers))
            .map { zipResponse -> CombinedLaunch in
                return CombinedLaunch(imageUrl: launchResponse.links.patch.large,
                                      rocketName: zipResponse.1.name,
                                      date: launchResponse.date,
                                      launchpadName: zipResponse.0.name,
                                      description: zipResponse.1.description ?? Constants.Strings.General.unknown)
            }.eraseToAnyPublisher()
        }.sink { _ in
            //  something went wrong 😔
        } receiveValue: { response in
            self.combinedLaunch = response
        }.store(in: &cancellables)
    }
}
