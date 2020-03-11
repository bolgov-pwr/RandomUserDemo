//
//  ViewController.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RandomUserViewController: UIViewController, RxBindable {
	
	static func storyboardInstance() -> RandomUserViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? RandomUserViewController
	}
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	let disposeBag = DisposeBag()
	
	var randomUserVM: RandomUserViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollection()
		setupBindings()
//		navigationController?.addCustomTransitioning()
		randomUserVM?.requestData()
	}
	
	private func setupCollection() {
		collectionView.register(PersonCell.nib(), forCellWithReuseIdentifier: String(describing: PersonCell.self))
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(refreshCollection(_:)), for: .valueChanged)
		collectionView.refreshControl = control
	}
	
	private func setupBindings() {
		
		// binding loading
		randomUserVM?.loading
			.bind(to: self.rx.isSpinnerAnimating).disposed(by: disposeBag)
		
		// observing errors
		randomUserVM?
			.error
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { (error) in
//				MessageView.sharedInstance.showOnView(message: error.localizedDescription, theme: .warning)
			})
			.disposed(by: disposeBag)
		
		randomUserVM?
			.users
			.bind(to: collectionView.rx.items(cellIdentifier: String(describing: PersonCell.self), cellType: PersonCell.self)) {  (row, person, cell) in
				cell.setup(with: person)
		}
		.disposed(by: disposeBag)
		
		Observable
			.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(Person.self))
			.bind { [weak self] indexPath, model in
				guard let cell = self?.collectionView.cellForItem(at: indexPath) as? PersonCell else { return }

				self?.navigationController?.view.layer.add(NavigationControllerAnimation.push, forKey: kCATransition)
				
				let vc = UserDescriptionViewController.storyboardInstance()!
				self?.navigationController?.pushViewController(vc, animated: true)
			}
			.disposed(by: disposeBag)

		collectionView
			.rx.prefetchItems
			.subscribe(onNext: { [weak self] indexPathes in
				guard let index = indexPathes.last?.row, let lastIndex = try? self?.randomUserVM?.users.value().endIndex,
					lastIndex - 1 == index else { return }
				self?.randomUserVM?.requestData()
			})
			.disposed(by: disposeBag)
		
		collectionView
			.rx.delegate
			.setForwardToDelegate(self, retainDelegate: false)
	}
}

extension RandomUserViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let cellWidth = (collectionView.bounds.width - 4) / 2
		return CGSize(width: cellWidth, height: cellWidth * 1.2)
	}
}
