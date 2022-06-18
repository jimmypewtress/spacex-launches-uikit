//
//  TestCase.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 13/06/2022.
//

import XCTest
import Combine
@testable import SpacexLauncherUIKit

class TestCase: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    var resetSingletonStorage: Bool = true
    var resetGlobal: Bool = true
    var mockNetwork: Bool = true
    
    var r: Resolver!
    var network: MockedRawNetwork!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        self.cancellables = []
        
        self.setMockFlags()
        self.initMocks()
        
        if self.resetSingletonStorage {
            let singleton = SingletonStorage()
            SingletonStorage.shared = singleton
        }

        setupResolver()
        
        if self.resetGlobal {
            let global = Global()
            Global.shared = global
        }
    }
    
    func setMockFlags() {
        // override if we need to switch any flags
    }
    
    func initMocks() {
        self.network = .init()
    }
    
    func setupResolver() {
        self.r = Resolver()
        
        if self.mockNetwork {
            self.r.api.network = self.network
        }
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        
        self.cancellables = []
        self.r = nil
        
        self.network = nil
    }
}
