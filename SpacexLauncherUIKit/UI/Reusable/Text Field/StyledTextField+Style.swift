//
//  StyledTextField+Style.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit

extension StyledTextField {
    struct Style {
        struct Colors {
            var text: UIColor
            var background: UIColor
            var border: UIColor?
        }
        
        struct StateColors {
            let invalid: Colors
            let normal: Colors
            let valid: Colors
            let disabled: Colors
        }
        
        var font: UIFont
        var stateColors: StateColors
        var colorChangeDuration: Double
        var hasBorder: Bool
        var cornerRadius: Double
        var rightImage: UIImage?
        

        init(font: UIFont,
             stateColors: StateColors,
             colorChangeDuration: Double = Constants.MagicNumbers.defaultAnimationDuration,
             hasBorder: Bool = true,
             cornerRadius: Double = Constants.MagicNumbers.defaultTextFieldCornerRadius,
             rightImage: UIImage? = nil) {
            self.font = font
            self.stateColors = stateColors
            self.colorChangeDuration = colorChangeDuration
            self.hasBorder = hasBorder
            self.cornerRadius = cornerRadius
            self.rightImage = rightImage
        }
    }
}
