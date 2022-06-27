//
//  StyledButton.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit

@IBDesignable
class StyledButton: UIButton {
    
    @IBInspectable var sbStyle: String = "bigAction"
    var style: Constants.Styles.Buttons = .bigAction {
        didSet {
            self.applyStyle()
        }
    }

    override var isEnabled: Bool {
        didSet {
            self.animateApplyColor()
        }
    }

    // MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.getStyleFromSb()
        self.applyStyle()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.getStyleFromSb()
        self.applyStyle()
    }
    
    // MARK: - customization
    private func getStyleFromSb() {
        if let style = Constants.Styles.Buttons(rawValue: self.sbStyle) {
            self.style = style
        }
    }
    
    private func applyStyle() {
        let style = self.style.style
        
        UIView.performWithoutAnimation {
            self.titleLabel?.font = style.font
            self.layoutIfNeeded()
        }
        
        if style.hasBorder {
            self.layer.borderWidth = Constants.MagicNumbers.defaultTextFieldBorderWidth.cgFloat
        }
        
        self.applyColor()
    }
    
    private func applyColor() {
        let style = self.style.style
        
        self.layer.cornerRadius = style.cornerRadius.cgFloat
        self.clipsToBounds = true
        
        if self.isEnabled {
            let fgColor = style.activeColors.text
            self.backgroundColor = style.activeColors.background
            self.setTitleColor(fgColor, for: .normal)
            self.setTitleColor(fgColor, for: .disabled)
            self.layer.borderColor = style.activeColors.border?.cgColor
        } else {
            let fgColor = style.inactiveColors.text
            self.backgroundColor = style.inactiveColors.background
            self.setTitleColor(fgColor, for: .normal)
            self.setTitleColor(fgColor, for: .disabled)
            self.layer.borderColor = style.inactiveColors.border?.cgColor
        }
    }
    
    private func animateApplyColor() {
        let style = self.style.style
        
        UIView.transition(with: self, duration: style.colorChangeDuration,
                          options: .transitionCrossDissolve, animations: {
            self.applyColor()
        })
    }
    
    func setUnderlinedTitle(_ title: String) {
        let attributedTitle = NSMutableAttributedString(string: title)
        let underline = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let range = NSRange(location: 0, length: attributedTitle.length)
        attributedTitle.addAttributes(underline, range: range)
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
