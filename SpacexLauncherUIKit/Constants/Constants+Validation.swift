//
//  Constants+Validation.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

extension Constants {
    struct Validation {
        enum regex: String {
            case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        }
        
        struct Length {
            static let loginPassword = (min: 1, max: 8)
        }
    }
}
