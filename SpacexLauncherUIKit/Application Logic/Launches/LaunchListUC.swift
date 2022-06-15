//
//  LauncheListUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Combine

protocol LaunchListUC {
    var launchesOutputPublisher: Published<LaunchesOutput?>.Publisher { get }
    
    func fetchLaunches()
}

class LaunchListUCImpl: BaseUC, LaunchListUC, ObservableObject {
    @Published var launchesOutput: LaunchesOutput? = nil
    var launchesOutputPublisher: Published<LaunchesOutput?>.Publisher { $launchesOutput }
    
    private let launchesRequest: ApiRequest<Payload.Launches>
    
    init(launchesRequest: ApiRequest<Payload.Launches>) {
        self.launchesRequest = launchesRequest
    }
    
    func fetchLaunches() {
        let input = Payload.Launches.Request(query: .init(), options: .init())
        let headers = Payload.Empty()
        
        self.launchesRequest.fetch(input, headers: headers).sink { _ in
            //  something went wrong 😔
        } receiveValue: { response in
            print("response = \(response)")
        }.store(in: &cancellables)
    }
}
