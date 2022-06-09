//
//  StyledButton+Style.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit

extension StyledButton {
    struct Style {
        struct Colors {
            var text: UIColor
            var background: UIColor
            var border: UIColor?
        }
        var font: UIFont
        
        var activeColors: Colors
        var inactiveColors: Colors
        var colorChangeDuration: Double
        var hasBorder: Bool
        var cornerRadius: Double
        
        init(font: UIFont,
             activeColors: Colors,
             inactiveColors: Colors,
             colorChangeDuration: Double = Constants.MagicNumbers.defaultAnimationDuration,
             isHasBorder: Bool = false,
             cornerRadius: Double = Constants.MagicNumbers.defaultButtonCornerRadius) {
            self.font = font
            self.activeColors = activeColors
            self.inactiveColors = inactiveColors
            self.colorChangeDuration = colorChangeDuration
            self.hasBorder = isHasBorder
            self.cornerRadius = cornerRadius
        }
    }
}
