//
//  ActivityIndicatorUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import Combine

protocol ActivityIndicatorUC {
    var isShownPublisher: Published<Bool>.Publisher { get }
    func showLoader()
    func hideLoader()
}

class ActivityIndicatorUCImpl: BaseUC, ActivityIndicatorUC, ObservableObject {
    @Published var isShown: Bool = false
    var isShownPublisher: Published<Bool>.Publisher { $isShown }
        
    private var counter: Int = 0 {
        didSet {
            if counter == 0 {
                self.isShown = false
            } else {
                self.isShown = true
            }
        }
    }
    func reset() {
        counter = 0
    }
    func showLoader() {
        counter += 1
    }
    
    func hideLoader() {
        counter = max(counter-1, 0)
    }
}
