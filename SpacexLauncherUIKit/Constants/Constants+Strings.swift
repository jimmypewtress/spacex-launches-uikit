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
            static let logout = NSLocalizedString("Logout", comment: "Logout")
            static let email = NSLocalizedString("Email", comment: "Email")
            static let password = NSLocalizedString("Password", comment: "Password")
            static let cancel = NSLocalizedString("Cancel", comment: "Cancel")
            static let ok = NSLocalizedString("OK", comment: "OK")
            static let unknown = NSLocalizedString("Unknown", comment: "Unknown")
        }
        struct Login {
            static let subHeading = NSLocalizedString("Enter your email and password", comment: "Subheading on Login Screen")
            static let forgotPasswordButtonTitle = NSLocalizedString("Forgot Password?", comment: "Title for Forgot Password button on Login Screen")
            static let loginButtonTitle = NSLocalizedString("Log In", comment: "Title for Login button on Login Screen")
            static let emailTextFieldPlaceHolder = NSLocalizedString("someone@domain.com", comment: "Placeholder for email text field on Login Screen")
        }
        
        struct ForgotPassword {
            static let heading = NSLocalizedString("Forgot Password", comment: "Heading on Forgot Password Screen")
            static let subHeading = NSLocalizedString("Enter your email below and we'll send you a link to reset your password", comment: "Subheading on Forgot Password Screen")
            static let sendLinkButtonTitle = NSLocalizedString("Send Link", comment: "Title for Send Link button on Forgot Password screen")
            static let successAlertTitle = NSLocalizedString("Sucess", comment: "Title for Send Link success alert on Forgot Password screen")
            static let successAlertMessage = NSLocalizedString("A link has been email to you", comment: "Message for Send Link success alert on Forgot Password screen")
        }
        
        struct Launches {
            static let navbarTitle = NSLocalizedString("Launches", comment: "Navbar heading for Launches screen")
            
            struct DetailCell {
                static let success = NSLocalizedString("Success", comment: "Heading for Success label in launch detail cell")
                static let date = NSLocalizedString("Date", comment: "Heading for Success label in launch detail cell")
            }
        }
    }
}
