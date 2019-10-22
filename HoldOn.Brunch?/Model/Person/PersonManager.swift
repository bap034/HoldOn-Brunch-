//
//  PersonManager.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/12/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

class PersonManager {
	// MARK: - Creation
	static func createNewPerson(name: String, imageURL: String?, moodStatus: MoodStatus) -> Person {
		let newPerson = Person(name: name, imageURLString: imageURL, moodStatus: moodStatus)
		return newPerson
	}
	
	// MARK: - HOBModelDatabaseProtocol
	static func getAllPersons(database: HOBModelDatabaseProtocol = HOBModelDatabase.shared, success: @escaping RetrieveSuccessBlock<Person>, failure: FailureBlock?) {
		database.getAllPersons(success: success, failure: failure)
	}
	static func storePerson(_ person: Person, database: HOBModelDatabaseProtocol = HOBModelDatabase.shared, success: StoreSuccessBlock?, failure: FailureBlock?) {
		database.storePerson(person, success: success, failure: failure)
	}
	
	// MARK: - HOBStorageProtocol
	static func getImageDataForPerson(_ person: Person, storage: HOBStorageProtocol = HOBStorage.shared, completion: @escaping (Data?)->Void) -> Data? {
		let filename = person.id
		if let existingData = storage.retrieveImageDataFromCache(filename: filename) {
			return existingData
		} else {
			storage.downloadImageDataToCache(filename: filename, success: {
				let data = storage.retrieveImageDataFromCache(filename: filename)
				completion(data)
			}) { (error) in
				completion(nil)
			}
		}
		
		return nil
	}
}
