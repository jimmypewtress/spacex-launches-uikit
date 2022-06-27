//
//  MockedLaunchDetailUC.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 27/06/2022.
//

@testable import SpacexLauncherUIKit
import Combine
import Foundation

class MockedLaunchDetailUC: BaseUC, LaunchDetailUC, ObservableObject {
    @Published var combinedLaunch: CombinedLaunch? = nil
    var combinedLaunchPublisher: Published<CombinedLaunch?>.Publisher { $combinedLaunch }
    
    var output: CombinedLaunch?
    
    func fetchLaunchDeatails(launchId: String) {
        self.combinedLaunch = self.output
    }
}
