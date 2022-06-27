//
//  StyledTextField.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit

@IBDesignable
class StyledTextField: UITextField {
    @IBInspectable var sbStyle: String = "normal"
    
    var style: Constants.Styles.TextFields = .normal {
        didSet {
            self.applyStyle()
        }
    }
    
    @IBInspectable var sbTextFieldState: String = "normal"
    
    var textFieldState: TextFieldState = .normal {
        didSet {
            if self.textFieldState == oldValue { return }
            if self.textFieldState == .disabled {
                self.isEnabled = false
            }
            self.animateApplyColor()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            let imageView = UIImageView(image: rightImage)
            imageView.contentMode = .scaleAspectFit
            
            switch self.textFieldState {
            case .invalid:
                imageView.tintColor = self.style.style.stateColors.invalid.text
            case .normal:
                imageView.tintColor = self.style.style.stateColors.normal.text
            case .valid:
                imageView.tintColor = self.style.style.stateColors.valid.text
            case .disabled:
                imageView.tintColor = self.style.style.stateColors.disabled.text
            }
            
            self.rightView = imageView
        }
    }
    
    // MARK: - padding
    @IBInspectable var rightImagePadding: CGFloat = Constants.MagicNumbers.textfieldImagePadding.cgFloat
    @IBInspectable var textPadding: CGFloat = Constants.MagicNumbers.textfieldTextPadding.cgFloat

    //padding for image
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var viewRect = super.rightViewRect(forBounds: bounds)
        viewRect.origin.x -= rightImagePadding
        viewRect.origin.y += (viewRect.size.height - Constants.MagicNumbers.textfieldImageSize.1.cgFloat)/2
        viewRect.size.width = Constants.MagicNumbers.textfieldImageSize.0.cgFloat
        viewRect.size.height = Constants.MagicNumbers.textfieldImageSize.1.cgFloat
        
        return viewRect
    }

    // padding for placeholder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        switch self.style {
        case .loginEmail, .loginPassword:
            return bounds.inset(by: UIEdgeInsets(top: .zero, left: textPadding, bottom: .zero, right: textPadding))
        default:
            return bounds
        }
    }
    
    // pading for text
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        switch self.style {
        case .loginEmail, .loginPassword:
            return bounds.inset(by: UIEdgeInsets(top: .zero, left: textPadding, bottom: .zero, right: textPadding))
        default:
            return bounds
        }
    }
    
    // MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.getStyleFromSb()
        self.getStateFromSb()
        self.applyStyle()
    }
    
    @objc func doneTapped () {
        self.resignFirstResponder()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.getStyleFromSb()
        self.getStateFromSb()
        self.applyStyle()
    }
    
    // MARK: - customization
    private func getStyleFromSb() {
        if let style = Constants.Styles.TextFields(rawValue: self.sbStyle) {
            self.style = style
        }
    }

    private func getStateFromSb() {
        if let state = TextFieldState(rawValue: self.sbTextFieldState) {
            self.textFieldState = state
        }
    }

    private func applyStyle() {
        let style = self.style.style
        
        self.font = style.font
        self.layer.cornerRadius = style.cornerRadius
        self.clipsToBounds = true
        
        self.applyColor()
        
        if style.hasBorder {
            self.borderStyle = .line
            self.layer.borderWidth = Constants.MagicNumbers.defaultTextFieldBorderWidth.cgFloat
        } else {
            self.borderStyle = .none
        }
        
        if let image = style.rightImage {
            self.rightViewMode = .always
            self.rightImage = image
        }
    }
    
    private func applyColor() {
        let style = self.style.style
        
        switch self.textFieldState {
        case .invalid:
            self.backgroundColor = style.stateColors.invalid.background
            self.textColor = style.stateColors.invalid.text
            self.layer.borderColor = style.stateColors.invalid.border?.cgColor
            self.rightViewMode = .always
        case .normal:
            self.backgroundColor = style.stateColors.normal.background
            self.textColor = style.stateColors.normal.text
            self.layer.borderColor = style.stateColors.normal.border?.cgColor
            self.rightViewMode = .never
        case .valid:
            self.backgroundColor = style.stateColors.valid.background
            self.textColor = style.stateColors.valid.text
            self.layer.borderColor = style.stateColors.valid.border?.cgColor
            self.rightViewMode = .never
        case .disabled:
            self.backgroundColor = style.stateColors.disabled.background
            self.textColor = style.stateColors.disabled.text
            self.layer.borderColor = style.stateColors.disabled.border?.cgColor
            self.rightViewMode = .never
        }
    }
    
    private func animateApplyColor() {
        let style = self.style.style
        
        UIView.transition(with: self, duration: style.colorChangeDuration,
                          options: .transitionCrossDissolve, animations: {
                            self.applyColor()
        })
    }
}

