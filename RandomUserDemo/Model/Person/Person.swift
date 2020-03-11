//
//  Person.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RealmSwift

final class Person: Object {
	
	@objc dynamic var first: String = ""
	@objc dynamic var last: String = ""
	@objc dynamic var pic: String = ""
	@objc dynamic var cell: String = ""
	
	required convenience init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		cell = try container.decodeIfPresent(String.self, forKey: .cell) ?? ""
		
		let nestedContainer = try container.nestedContainer(keyedBy: RatingsCodingKeys.self, forKey: .name)
		first = try nestedContainer.decodeIfPresent(String.self, forKey: .first) ?? ""
		last = try nestedContainer.decodeIfPresent(String.self, forKey: .last) ?? ""
		
		let picContainer = try container.nestedContainer(keyedBy: PictureCodingKeys.self, forKey: .picture)
		pic = try picContainer.decodeIfPresent(String.self, forKey: .large) ?? ""
	}
	
	override static func primaryKey() -> String? {
		return "cell"
	}
}

extension Person: Codable {
	
	enum CodingKeys: String, CodingKey {
		case name
		case picture
		case cell
	}
	enum RatingsCodingKeys: String, CodingKey {
		case first
		case last
	}
	enum PictureCodingKeys: String, CodingKey {
		case large
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		var nestedContainer = container.nestedContainer(keyedBy: RatingsCodingKeys.self, forKey: .name)
		var picContainer = container.nestedContainer(keyedBy: PictureCodingKeys.self, forKey: .picture)
		
		try nestedContainer.encode(first, forKey: .first)
		try nestedContainer.encode(last, forKey: .last)
		try picContainer.encode(pic, forKey: .large)
	}
}
