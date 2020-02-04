//
//  PersonDetailsViewModel.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Combine
import UIKit

class PersonDetailsViewModel: ObservableObject {
	@Published var name: String	// TODO: how to remove duplicating properties. can Person hold observable details?
	@Published var image: UIImage?
	@Published var moodStatus: MoodStatus
	@Published var messageCellVMs = [MessageCellViewModel]()
	@Published var enteredMessageText = ""
	@Published var isPostButtonEnabled = true
	
	var onPostMessage: (()->Void)?
	
	init(name: String, image: UIImage?, moodStatus: MoodStatus) {
		self.name = name
		self.image = image
		self.moodStatus = moodStatus
	}
	
	convenience init(person: Person) {
		self.init(name: person.name, image: nil, moodStatus: person.moodStatus)
	}
}
