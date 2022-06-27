//
//  ImageCell.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 24/06/2022.
//

import UIKit
import Combine

class ImageCell: UITableViewCell, CustomCell {
    @IBOutlet weak var contentImageView: UIImageView!
    
    private var cancellable: AnyCancellable?
    
    class func register(with tableView: UITableView) {
        let nib = UINib(nibName: Constants.DetailCells.Image.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.DetailCells.Image.reuseIdentifier)
    }
    
    func configure(with row: TableRow, indexPath: IndexPath) {
        if let row = row as? DetailRow, case .image(let model) = row {
            if let imageUrlString = model.url,
                let imageUrl = URL(string: imageUrlString) {
                self.cancellable = self.loadImage(at: imageUrl).sink {
                    [unowned self] image in self.showImage(image: image)
                }
            } else {
                self.showImage(image: UIImage(systemName: Constants.Launches.noUrlImageName))
            }
        }
    }
    
    private func showImage(image: UIImage?) {
        self.contentImageView.image = image
        //self.spinner.alpha = 0
    }

    private func loadImage(at url: URL) -> AnyPublisher<UIImage?, Never> {
        return ImageLoader.shared.loadImage(from: url).eraseToAnyPublisher()
    }
}
