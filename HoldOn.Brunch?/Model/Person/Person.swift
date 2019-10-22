//
//  Person.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

enum MoodStatus: String, Codable {
	case new
	case confusing
	case confused
}

struct Person: ModelProtocol {
	// ModelProtocol
	var id: String { return name.lowercased() }
	
	var name: String
	var imageURLString: String?
	var moodStatus: MoodStatus
}

extension Person {
	var imageURL: URL? {
		guard let sureImageURLString = imageURLString else { return nil }
		
		let url = URL(string: sureImageURLString)
		return url
	}
}
