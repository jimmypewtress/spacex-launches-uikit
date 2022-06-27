//
//  BaseVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import Foundation
import Combine

class BaseVM: NSObject {
    var cancellables: Set<AnyCancellable> = []
    
    override init() {
        super.init()
        self.subscribe()
    }
    
    func subscribe() {
        //  subscribe to any published objects in here
    }
}
