//
//  UserDefaults+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

private let personKey = "kperson"
private let moodStatusKey = "kMoodStatus"

extension UserDefaults {
	// MARK: - Person
	static func storePerson(_ person: Person) {
		// MoodStatus
		UserDefaults.standard.set(person.moodStatus, forKey: moodStatusKey)
	}
	
	static func getPerson() -> Person {
		// MoodStatus
		let moodStatusString = UserDefaults.standard.string(forKey: moodStatusKey)
		
		let moodStatus: MoodStatus
		if let sureMoodStatusString = moodStatusString {
			let determinedMoodStatus = MoodStatus(rawValue: sureMoodStatusString)
			moodStatus = determinedMoodStatus ?? .new
		} else {
			moodStatus = .new
		}
		
		let person = Person(name: "Baller", imageName: "cat", moodStatus: moodStatus)
		return person
	}
}
