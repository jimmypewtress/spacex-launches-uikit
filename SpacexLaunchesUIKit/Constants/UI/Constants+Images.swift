//
//  Constants+Images.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit

extension Constants {
    struct Images {
        enum SFSymbol: String {
            case eye = "eye"
            
            var image: UIImage? {
                return UIImage(systemName: self.rawValue)
            }
        }
    }
}
