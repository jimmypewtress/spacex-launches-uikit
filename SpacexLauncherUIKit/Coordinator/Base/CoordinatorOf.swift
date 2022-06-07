//
//  CoordinatorOf.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

// treat as an interface of a generic type
// assocated types can only be used as constraints so can't use a protocol here
class CoordinatorOf<Type> {
    func start(_ obj: Type) {
        fatalError("start method not implemented")
    }
}
