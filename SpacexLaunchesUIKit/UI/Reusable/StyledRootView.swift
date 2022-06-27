//
//  StyledRootView.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 08/06/2022.
//

import UIKit

@IBDesignable
class StyledRootView: UIView {
    // MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyStyle()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.applyStyle()
    }
    
    // MARK: - customization
    private func applyStyle() {
        self.backgroundColor = Constants.Styles.Colours.viewBackground
    }
}
