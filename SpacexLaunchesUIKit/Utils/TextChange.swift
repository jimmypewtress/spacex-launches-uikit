//
//  TextChange.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit

struct TextChange {
    enum ValidationRule {
        case regex(String)
        case minLength(Int)
        case maxLength(Int)
        case alwaysTrue
        
        func validate(_ textChange: TextChange) -> Bool {
            switch self {
            case .regex(let regex):
                return textChange.newText.range(of: regex,
                                                options: .regularExpression,
                                                range: nil,
                                                locale: nil) == nil
            case .minLength(let length):
                return textChange.newText.count < length
            case .maxLength(let length):
                return textChange.newText.count > length
            case .alwaysTrue:
                return true
            }
        }
    }
    
    enum ValidationResult {
        case success
        case softFailure // bad, but allow the change
        case hardFailure // change shouldn't be allowed
    }

    struct Validator {
        let rule: ValidationRule
        let action: (() -> ValidationResult)
    }
    
    let oldText: String
    let changeRange: NSRange
    let replacementString: String
    
    var newText: String
    
    init(oldText: String,
         changeRange: NSRange,
         replacementString: String) {
        self.oldText = oldText
        self.changeRange = changeRange
        self.replacementString = replacementString
        
        if let textRange = Range(changeRange, in: oldText) {
            self.newText = oldText.replacingCharacters(in: textRange,
                                                       with: replacementString)
        } else {
            self.newText = oldText
        }
    }
    
    func validate(_ validators: [Validator]) -> ValidationResult {
        if let failedValidator = validators.first(where: { (validator) -> Bool in
            return validator.rule.validate(self)
        }) {
            return failedValidator.action()
        }
        return .success
    }
}
