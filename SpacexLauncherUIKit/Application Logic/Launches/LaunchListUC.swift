//
//  LauncheListUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Combine

protocol LaunchListUC {
    var launchesOutputPublisher: Published<LaunchesOutput?>.Publisher { get }
    
    func fetchLaunches(currentIndex: Int, pageSize: Int)
}

class LaunchListUCImpl: BaseUC, LaunchListUC, ObservableObject {
    @Published var launchesOutput: LaunchesOutput? = nil
    var launchesOutputPublisher: Published<LaunchesOutput?>.Publisher { $launchesOutput }
    
    private let launchesRequest: ApiRequest<Payload.Launches>
    
    init(launchesRequest: ApiRequest<Payload.Launches>) {
        self.launchesRequest = launchesRequest
    }
    
    func fetchLaunches(currentIndex: Int, pageSize: Int) {
        let requestOptions = LaunchesInputOptions(offset: currentIndex, limit: pageSize)
        
        let input = Payload.Launches.Request(query: .init(), options: requestOptions)
        let headers = Payload.Empty()
        
        self.launchesRequest.fetch(input, headers: headers).sink { _ in
            //  something went wrong 😔
        } receiveValue: { response in
            self.launchesOutput = response
        }.store(in: &cancellables)
    }
}
