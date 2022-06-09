//
//  Constants+Colours.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 08/06/2022.
//

import UIKit

extension Constants.Styles {
    struct Colours {
        static let viewBackground = Constants.ColourPalette.lightGray
        static let labelMain = Constants.ColourPalette.darkGray
        static let largeInfoText = Constants.ColourPalette.darkerLightGray
        
        static let textFieldInvalid = Constants.ColourPalette.mediumGray
        static let textFieldNormal = Constants.ColourPalette.mediumGray
        static let textFieldValid = Constants.ColourPalette.mediumGray
        static let textFieldDisabled = Constants.ColourPalette.mediumGray

        static let textFieldInvalidBg = Constants.ColourPalette.lightRed
        static let textFieldNormalBg = Constants.ColourPalette.white
        static let textFieldValidBg = Constants.ColourPalette.lightGreen
        static let textFieldDisabledBg = Constants.ColourPalette.white
        static let textFieldInvalidBorder = Constants.ColourPalette.darkRed
        static let textFieldNormalBorder = Constants.ColourPalette.mediumGray
        static let textFieldInvalidTextColor = Constants.ColourPalette.darkRed
        
        static let buttonActive = Constants.ColourPalette.darkBlue
        static let buttonInactive = Constants.ColourPalette.darkGray
    }
}

extension Constants {
    struct ColourPalette {
        static let white = UIColor.white
        static let clear = UIColor.clear
        
        static let darkGray = "263238".toColor
        static let lightGray = "F8F7F7".toColor
        static let mediumGray = "A3A5A6".toColor
        static let darkerLightGray = "A3A5A6".toColor
        
        static let lightRed = "FFEEEE".toColor
        static let darkRed = "AE0C14".toColor
        static let lightGreen = "EEFFEE".toColor
        static let darkBlue = "005288".toColor
    }
}
        
