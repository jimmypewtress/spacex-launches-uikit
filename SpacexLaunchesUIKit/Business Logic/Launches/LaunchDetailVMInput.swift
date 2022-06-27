//
//  LaunchDetailVMInput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

struct LaunchDetailVMInput: Equatable {
    let id: String
    let rocketName: String
    
    init(id: String,
         rocketName: String) {
        self.id = id
        self.rocketName = rocketName
    }
}
