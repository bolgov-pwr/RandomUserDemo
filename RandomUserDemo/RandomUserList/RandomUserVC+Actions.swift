//
//  RandomUserVC+Actions.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation

extension RandomUserViewController {

	@objc func refreshCollection(_ sender: Any) {
		randomUserVM?.requestData(isReload: true)
		collectionView.refreshControl?.endRefreshing()
	}
}
