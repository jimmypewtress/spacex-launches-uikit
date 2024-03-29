//
//  Constants+Styles.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 08/06/2022.
//

import UIKit

extension Constants {
    struct Styles {
        enum Labels: String {
            case normalLabelInfo16
            case semiboldLabelMain26
            case mediumLabelMain14
            case normalLabelMain13
            case boldLabelMain20
            case normalLabelInfo14
            case boldLabelMain18
            
            var style: StyledLabel.Style {
                switch self {
                case .normalLabelInfo16:
                    return .init(font: UIFont.systemFont(ofSize: 16),
                                 colour: Colours.largeInfoText)
                case .semiboldLabelMain26:
                    return .init(font: UIFont.systemFont(ofSize: 26, weight: .semibold),
                                 colour: Colours.labelMain)
                case .mediumLabelMain14:
                    return .init(font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                 colour: Colours.labelMain)
                case .normalLabelMain13:
                    return .init(font: UIFont.systemFont(ofSize: 13),
                                 colour: Colours.labelMain)
                case .boldLabelMain20:
                    return .init(font: UIFont.systemFont(ofSize: 20, weight: .bold),
                                 colour: Colours.labelMain)
                case .normalLabelInfo14:
                    return .init(font: UIFont.systemFont(ofSize: 14),
                                 colour: Colours.largeInfoText)
                case .boldLabelMain18:
                    return .init(font: UIFont.systemFont(ofSize: 18, weight: .bold),
                                 colour: Colours.labelMain)
                }
            }
        }
        
        enum TextFields: String {
            case normal
            case loginEmail
            case loginPassword
            
            var style: StyledTextField.Style {
                switch self {
                case .normal:
                    return .init(
                        font: UIFont.systemFont(ofSize: 14),
                        stateColors: .init(
                            invalid: .init(text: Colours.textFieldInvalid,
                                           background: Colours.textFieldInvalidBg),
                            normal: .init(text: Colours.textFieldNormal,
                                          background: Colours.textFieldNormalBg),
                            valid: .init(text: Colours.textFieldValid,
                                         background: Colours.textFieldValidBg),
                            disabled: .init(text: Colours.textFieldDisabled,
                                            background: Colours.textFieldDisabledBg)
                        )
                    )
                    
                case .loginEmail:
                    return .init(
                        font: UIFont.systemFont(ofSize: 16),
                        stateColors: .init(
                            invalid: .init(text: Colours.textFieldInvalid,
                                           background: Colours.textFieldNormalBg,
                                           border: Colours.textFieldInvalidBorder),
                            normal: .init(text: Colours.textFieldNormal,
                                          background: Colours.textFieldNormalBg,
                                          border: Colours.viewBackground),
                            valid: .init(text: Colours.textFieldValid,
                                         background: Colours.textFieldValidBg,
                                         border: ColourPalette.darkGreen),
                            disabled: .init(text: Colours.textFieldDisabled,
                                            background: Colours.textFieldDisabledBg,
                                            border:  Colours.viewBackground)
                        ),
                        hasBorder: true,
                        cornerRadius: 10.0
                    )
                    
                case .loginPassword:
                    return .init(
                        font: UIFont.systemFont(ofSize: 16),
                        stateColors: .init(
                            invalid: .init(text: Colours.textFieldInvalid,
                                           background: Colours.textFieldNormalBg),
                            normal: .init(text: Colours.textFieldNormal,
                                          background: Colours.textFieldNormalBg),
                            valid: .init(text: Colours.textFieldValid,
                                         background: Colours.textFieldValidBg),
                            disabled: .init(text: Colours.textFieldDisabled,
                                            background: Colours.textFieldDisabledBg)
                        ),
                        hasBorder: false,
                        cornerRadius: 10.0,
                        rightImage: Constants.Images.SFSymbol.eye.image
                    )
                }
            }
        }

            
        enum Buttons: String {
            case darkBlueText
            case bigAction
            
            var style: StyledButton.Style {
                switch self {
                case .darkBlueText:
                    return .init(font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                 activeColors: .init(text: Colours.buttonActive,
                                                     background: Constants.ColourPalette.clear),
                                 inactiveColors: .init(text: Colours.buttonActive,
                                                       background: Constants.ColourPalette.clear))
                case .bigAction:
                    return .init(font: UIFont.systemFont(ofSize: 18, weight: .bold),
                                 activeColors: .init(text: Colours.viewBackground,
                                                     background: Colours.buttonActive),
                                 inactiveColors: .init(text: Colours.viewBackground,
                                                       background: Colours.buttonInactive))
                }
            }
        }
    }
}
