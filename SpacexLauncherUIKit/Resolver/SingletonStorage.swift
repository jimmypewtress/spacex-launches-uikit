//
//  SingletonStorage.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

class SingletonStorage {
    static var shared = SingletonStorage()
    
    private var singletonStorage: [String: Any] = [:]
    
    func singleton<Type>(createFn: () -> Type) -> Type {
        let id = String(describing: Type.self)
        
        if let obj = singletonStorage[id] as? Type {
            return obj
        }
        
        let obj = createFn()
        singletonStorage[id] = obj
        return obj
    }
    
    func flush() {
        self.singletonStorage = [:]
    }
}


extension Resolver {
    static func singleton<Type>(createFn: () -> Type) -> Type {
        return SingletonStorage.shared.singleton(createFn: createFn)
    }
}
