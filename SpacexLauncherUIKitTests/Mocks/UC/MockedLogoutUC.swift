//
//  MockedLogoutUC.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

@testable import SpacexLauncherUIKit
import Combine

class MockedLogoutUC: LogoutUC {
    var logoutCalledCounter = 0
    
    func logout() {
        self.logoutCalledCounter += 1
    }
}
