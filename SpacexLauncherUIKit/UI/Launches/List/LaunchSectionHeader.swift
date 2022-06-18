//
//  LaunchSectionHeader.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 16/06/2022.
//

import UIKit

class LaunchSectionHeader: UIViewController {
    // MARK: - Creation
    class func createVC(month: String, year: String) -> LaunchSectionHeader {
        return Utils.createVC(storyboard: .launchList) { vc in
            vc.monthString = month
            vc.yearString = year
        }
    }

    // MARK: - input
    private var monthString: String!
    private var yearString: String!

    // MARK: - Outlets
    
    @IBOutlet weak var monthLabel: StyledLabel!
    @IBOutlet weak var yearLabel: StyledLabel!
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        #if LOGGING_ENABLED
        Logger.log(category: .viewLifecycle)
        #endif
        
        super.viewDidLoad()
        
        self.monthLabel.text = self.monthString
        self.yearLabel.text = self.yearString
    }
}
