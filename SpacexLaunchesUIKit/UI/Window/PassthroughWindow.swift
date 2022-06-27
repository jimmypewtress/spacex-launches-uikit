//
//  PassthroughWindow.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import UIKit
import Combine

class PassthroughWindow: UIWindow {
    private let boolPublisher: Published<Bool>.Publisher
    private var shouldCaptureHits = false
    
    private var cancellable: AnyCancellable?
    
    init(windowScene: UIWindowScene,
         boolPublisher: Published<Bool>.Publisher) {
        self.boolPublisher = boolPublisher
        
        super.init(windowScene: windowScene)
        
        self.subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribe() {
        self.cancellable = self.boolPublisher.sink { shouldCaptureHits in
            self.shouldCaptureHits = shouldCaptureHits
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.shouldCaptureHits{
            return super.hitTest(point, with: event)
        }
        
        return nil
    }
}
