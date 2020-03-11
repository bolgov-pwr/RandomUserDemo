//
//  Persons.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation

final class Persons : Codable {
	let persons : [Person]?
	
	enum CodingKeys: String, CodingKey {
		case persons = "results"
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		persons = try values.decodeIfPresent([Person].self, forKey: .persons)
	}
}
