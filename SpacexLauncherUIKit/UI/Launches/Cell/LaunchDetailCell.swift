//
//  LaunchDetailCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import UIKit
import Combine

class LaunchDetailCell: UITableViewCell, LaunchCell {
    @IBOutlet weak var rocketLabel: StyledLabel!
    @IBOutlet weak var successLabel: StyledLabel!
    @IBOutlet weak var successValueLabel: StyledLabel!
    @IBOutlet weak var dateLabel: StyledLabel!
    @IBOutlet weak var dateValueLabel: StyledLabel!
    @IBOutlet weak var patchImageView: UIImageView!
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    private let strings = Constants.Strings.Launches.DetailCell.self
    
    func configure(with row: LaunchRow, indexPath: IndexPath) {
        if case .cell(let launch) = row {
            self.rocketLabel.text = launch.rocketName
            self.successLabel.text = strings.success + ":"
            self.successValueLabel.text = launch.success
            self.dateLabel.text = strings.date + ":"
            self.dateValueLabel.text = launch.date
            
            if let patchUrlString = launch.patchUrl,
                let patchUrl = URL(string: patchUrlString) {
                self.cancellable = self.loadImage(at: patchUrl).sink {
                    [unowned self] image in self.showImage(image: image)
                }
            }
        }
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        self.patchImageView.image = nil
        self.patchImageView.alpha = 0.0
        self.animator?.stopAnimation(true)
        self.cancellable?.cancel()
    }
    
    private func showImage(image: UIImage?) {
        self.patchImageView.alpha = 0.0
        self.animator?.stopAnimation(false)
        self.patchImageView.image = image
        self.animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.patchImageView.alpha = 1.0
        })
    }

    private func loadImage(at url: URL) -> AnyPublisher<UIImage?, Never> {
        return ImageLoader.shared.loadImage(from: url).eraseToAnyPublisher()
    }
}
