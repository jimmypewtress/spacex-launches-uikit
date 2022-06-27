//
//  StyledLabel.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 08/06/2022.
//

import UIKit

@IBDesignable
class StyledLabel: UILabel {
    @IBInspectable var sbStyle: String = "semiboldLabelMain26"
    
    var style: Constants.Styles.Labels = .semiboldLabelMain26 {
        didSet {
            self.applyStyle()
        }
    }
    
    // MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.getStyleFromStoryboard()
        self.applyStyle()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.getStyleFromStoryboard()
        self.applyStyle()
    }
    
    // MARK: - customization
    private func getStyleFromStoryboard() {
        if let style = Constants.Styles.Labels(rawValue: self.sbStyle) {
            self.style = style
        }
    }
    
    private func applyStyle() {
        let style = self.style.style
        self.textColor = style.colour
        self.font = style.font
    }
}

