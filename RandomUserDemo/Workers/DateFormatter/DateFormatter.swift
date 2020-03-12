//
//  DateFormatter.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/12/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation

final class MyDateFormatter {
	
	static let shared = MyDateFormatter()
	
	private let dateFormatterGet: DateFormatter
	private let dateFormatterPrint: DateFormatter
	
	private init() {
		dateFormatterGet = DateFormatter()
		dateFormatterPrint = DateFormatter()
	}
	
	func convert(_ dateString: String) -> String {
		
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterPrint.dateFormat = "YYYY-mm-dd"
		
		let date: Date? = dateFormatterGet.date(from: dateString)
		
		if let correctDate = date {
			return dateFormatterPrint.string(from: correctDate)
		} else {
			return dateString
		}
	}
}
