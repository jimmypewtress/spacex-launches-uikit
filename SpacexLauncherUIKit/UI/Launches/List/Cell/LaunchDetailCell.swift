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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var cancellable: AnyCancellable?
    private let strings = Constants.Strings.Launches.DetailCell.self
    
    func configure(with row: LaunchRow, indexPath: IndexPath) {
        if case .cell(let launch) = row {
            self.rocketLabel.text = launch.rocketName
            self.successLabel.text = strings.success + ":"
            self.successValueLabel.text = launch.success
            self.dateLabel.text = strings.date + ":"
            self.dateValueLabel.text = launch.dateString
            
            if let patchUrlString = launch.patchUrl,
                let patchUrl = URL(string: patchUrlString) {
                self.cancellable = self.loadImage(at: patchUrl).sink {
                    [unowned self] image in self.showImage(image: image)
                }
            } else {
                self.showImage(image: UIImage(systemName: Constants.Launches.noUrlImageName))
            }
        }
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
    
        self.patchImageView.image = nil

        self.cancellable?.cancel()
        self.spinner.alpha = 1
        self.spinner.startAnimating()
    }
    
    private func showImage(image: UIImage?) {
        self.patchImageView.image = image
        self.spinner.alpha = 0
    }

    private func loadImage(at url: URL) -> AnyPublisher<UIImage?, Never> {
        return ImageLoader.shared.loadImage(from: url).eraseToAnyPublisher()
    }
}
