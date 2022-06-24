//
//  IdOnlyInput.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 20/06/2022.
//

struct IdOnlyInput: Codable {
    var endpointParams: [String]
    
    init(id: String) {
        self.endpointParams = [id]
    }
}
