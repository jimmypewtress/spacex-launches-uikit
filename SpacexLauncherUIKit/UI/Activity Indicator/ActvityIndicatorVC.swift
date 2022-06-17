//
//  ActvityIndicatorVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 17/06/2022.
//

import UIKit

class ActivityIndicatorVC: BaseVC {
    private var useCase: ActivityIndicatorUC!
    
    // MARK: - Constructor
    class func createVC(useCase: ActivityIndicatorUC) -> ActivityIndicatorVC {
        return Utils.createVC(storyboard: .activityIndicator) { vc in
            vc.useCase = useCase
        }
    }

    @IBOutlet weak var containerView: UIView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
    }
    
    private func configureUI() {
        self.containerView.alpha = 0
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = Constants.MagicNumbers.defaultCornerRadius.cgFloat
        self.containerView.backgroundColor = Constants.ColourPalette.black.withAlphaComponent(0.7)
    }
    
    override func subscribe() {
        self.useCase.isShownPublisher.sink { isShown in
            UIView.animate(withDuration: Constants.MagicNumbers.defaultAnimationDuration, delay: 0) {
                DispatchQueue.main.async {
                    self.containerView.alpha = isShown ? 1 : 0
                }
            }
        }.store(in: &cancellables)
    }
}
