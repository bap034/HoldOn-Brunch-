//
//  PersonDetails.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class PersonDetails: ObservableObject {
	@Published var name: String	// TODO: how to remove duplicating properties. can Person hold observable details?
	@Published var image: UIImage?
	@Published var moodStatus: MoodStatus
	@Published var messages = [Message]()
	
	init(name: String, image: UIImage?, moodStatus: MoodStatus) {
		self.name = name
		self.image = image
		self.moodStatus = moodStatus
	}
	
	convenience init(person: Person) {
		self.init(name: person.name, image: nil, moodStatus: person.moodStatus)
	}
}
