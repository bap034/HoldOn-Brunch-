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
	var imageName: String?
	var moodStatus: MoodStatus
}
