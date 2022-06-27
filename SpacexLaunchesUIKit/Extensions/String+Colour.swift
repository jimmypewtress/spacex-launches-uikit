//
//  String+Colour.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 08/06/2022.
//

import Foundation
import UIKit

extension String {
    var toColor: UIColor {
        guard let (a, r, g, b) = argb(hexColor: self) else { return UIColor.black }
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    // Return color components in range [0,1] for hexadecimal color strings.
    // hexColor: case-insensitive string with format RGB, RRGGBB, or AARRGGBB.
    private func argb(hexColor: String) -> (CGFloat, CGFloat, CGFloat, CGFloat)? {
        let hexAlphabet = "0123456789abcdefABCDEF"
        let hex = hexColor.trimmingCharacters(in: CharacterSet(charactersIn: hexAlphabet).inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17) // RGB
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF) // RRGGBB
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF) // AARRGGBB
        default: return nil
        }
        return (CGFloat(a)/255, CGFloat(r)/255, CGFloat(g)/255, CGFloat(b)/255)
    }
}

