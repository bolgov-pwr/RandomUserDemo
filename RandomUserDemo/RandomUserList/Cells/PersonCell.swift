//
//  PersonCell.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import RxSwift

final class PersonCell: UICollectionViewCell, RxBindable {
	
	static func nib() -> UINib {
		let nib = UINib(nibName: String(describing: self), bundle: nil)
		return nib
	}


	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var cellNumberLabel: UILabel!
	@IBOutlet weak var avatarImageView: UIImageView!

	var disposeBag = DisposeBag()

	var getImage: UIImage? {
		return avatarImageView.image
	}
	
	private var imageURL: URL?

	override func prepareForReuse() {
		super.prepareForReuse()

		avatarImageView.image = nil
		nameLabel.text = ""
		cellNumberLabel.text = ""
		disposeBag = DisposeBag()
	}

	func setup(with person: Person) {
		nameLabel.text = "\(person.first) \(person.last)"
		cellNumberLabel.text = "num. \(person.cell)"

		guard let imagePath = URL(string: person.pic) else { return }
		self.imageURL = imagePath
		DispatchQueue.global(qos: .background).async { [weak self] in
			if let data = try? Data(contentsOf: imagePath),
				imagePath == self?.imageURL,
				let img = UIImage(data: data) {

				DispatchQueue.main.async { [weak self] in
					self?.avatarImageView.alpha = 0
					UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
						self?.avatarImageView.resizedImage(image: img, cornerRadius: .cicle)
						self?.avatarImageView.alpha = 1
					}, completion: nil)
				}
			}
		}
	}	
}
