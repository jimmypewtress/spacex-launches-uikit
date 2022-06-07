//
//  CoordinatorImpl.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

class CoordinatorImpl<Type>: CoordinatorOf<Type> {
    
    override func start(_ obj: Type) {
        self.onStart(obj)
    }

    //  overide this method in subclasses
    func onStart(_ obj: Type, r: Resolver = Resolver()) {
        fatalError("onStart method not implemented")
    }
}

extension CoordinatorImpl: Coordinator where Type == Void {
    func start() {
        self.start(Void())
    }
}
