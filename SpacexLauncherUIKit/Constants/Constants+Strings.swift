//
//  Constants+Text.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import Foundation

extension Constants {
    struct Strings {
        struct General {
            static let login = NSLocalizedString("Login", comment: "Login")
            static let email = NSLocalizedString("Email", comment: "Email")
            static let password = NSLocalizedString("Password", comment: "Password")
        }
        struct Login {
            static let subHeading = NSLocalizedString("Enter your email and password", comment: "Subheading on Login Screen")
            static let emailTextFieldHeading = NSLocalizedString("Email/Phone", comment: "Heading for email field on Login Screen")
            static let forgotPasswordButtonTitle = NSLocalizedString("Forgot Password?", comment: "Title for Forgot Password button on Login Screen")
            static let loginButtonTitle = NSLocalizedString("Log In", comment: "Title for Login button on Login Screen")
            static let emailTextFieldPlaceHolder = NSLocalizedString("someone@domain.com", comment: "Placeholder for email text field on Login Screen")
        }
    }
}
