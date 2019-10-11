//
//  UserDefaults+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

private let personsKey = "kPersons" // Used to know what key values saved Persons are stored at

extension UserDefaults {
	// MARK: - Person
	func storePerson(_ person: Person) {
		let newPersonKey = person.name
		var personsKeys = getPersonsKeys()
		
		// Update Persons Keys
		if !personsKeys.contains(newPersonKey) {
			personsKeys.append(newPersonKey)
			setPersonsKeys(personsKeys)
		}
		
		// Store Person JSON
		if let jsonString = person.toJSONString() {
			set(jsonString, forKey: newPersonKey)
		}
	}
	
	func getPersonForKey(_ key: String) -> Person? {
		let jsonString = string(forKey: key)
		let person: Person? = jsonString?.toDecodable()
		return person
	}
	func getAllPersonsForKeys(_ keys: [String]) -> [Person] {
		var persons = [Person]()
		keys.forEach { (key) in
			if let person = getPersonForKey(key) {
				persons.append(person)
			}
		}
		return persons
	}
	
	func deletePerson(_ person: Person) {
		var personsKeys = getPersonsKeys()
		
		personsKeys.removeAll(where: { $0 == person.name })
		setPersonsKeys(personsKeys)
	}
	
	func setPersonsKeys(_ personsKeys: [String]) {
		set(personsKeys, forKey: personsKey)
	}
	
	/// Returns an array of keys with stored users
	func getPersonsKeys() -> [String] {
		let personsKeys = array(forKey: personsKey) as? [String]
		return personsKeys ?? []
	}
	
	static func getBallerPerson() -> Person {
		let person = Person(name: "Baller", imageName: "baller", moodStatus: MoodStatus.confusing)
		return person
	}
	
	static func getDoryPerson() -> Person {
		let person = Person(name: "Dory", imageName: "dory", moodStatus: MoodStatus.confused)
		return person
	}
}
