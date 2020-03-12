//
//  UserDescriptionViewController.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import RxSwift

final class UserDescriptionViewController: UIViewController, RxBindable {

	static func storyboardInstance() -> UserDescriptionViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? UserDescriptionViewController
	}
	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var genderLabel: UILabel!
	@IBOutlet weak var birthdayLabel: UILabel!
	@IBOutlet weak var callButton: UIButton!
	
	@IBAction func callButtonPressed(_ sender: Any) {
		guard let phone = try? person.value().cell, let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) else { return }
//		if let phone = try? person.value().cell, let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
			if #available(iOS 10, *) {
				UIApplication.shared.open(url)
			} else {
				UIApplication.shared.openURL(url)
			}
//		}
	}
	
	let disposeBag: DisposeBag = DisposeBag()
	let person: BehaviorSubject<Person> = BehaviorSubject(value: Person())
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setupBinding()
    }
	
	private func setupBinding() {
		person.observeOn(MainScheduler.instance)
			.subscribe(onNext: { person in
				self.setupView(person: person)
			})
			.disposed(by: disposeBag)
	}
	
	private func setupView(person: Person) {
		
		let fullName = "\(person.first) \(person.last)"
		navigationItem.title = fullName
		nameLabel.text = fullName
		genderLabel.text = person.gender.capitalized
		birthdayLabel.text = MyDateFormatter.shared.convert(person.birthday)
		callButton.setTitle("num. \(person.cell)", for: .normal)

		guard let imagePath = URL(string: person.pic) else { return }

		DispatchQueue.global(qos: .background).async { [weak self] in
			if let data = try? Data(contentsOf: imagePath), let img = UIImage(data: data) {

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
