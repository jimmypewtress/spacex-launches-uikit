//
//  MockedLaunchListUC.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

@testable import SpacexLauncherUIKit
import Combine

class MockedLaunchListUC: LaunchListUC, ObservableObject {
    @Published var launchesOutput: LaunchesOutput?
    var launchesOutputPublisher: Published<LaunchesOutput?>.Publisher { $launchesOutput }
    
    var output: LaunchesOutput?
    var shouldReturn = true
    var fetchCalledCounter = 0
    
    func fetchLaunches(currentIndex: Int, pageSize: Int, showSpinner: Bool) {
        fetchCalledCounter += 1
        
        if shouldReturn {
            self.launchesOutput = output
        }
    }
}
