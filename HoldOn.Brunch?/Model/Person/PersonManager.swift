//
//  PersonManager.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/12/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

class PersonManager {
	static func getAllPersons(database: HOBModelDatabaseProtocol = HOBModelDatabase.shared, success: @escaping RetrieveSuccessBlock<Person>, failure: FailureBlock?) {
		database.getAllPersons(success: success, failure: failure)
	}
	static func storePerson(_ person: Person, database: HOBModelDatabaseProtocol = HOBModelDatabase.shared, success: StoreSuccessBlock?, failure: FailureBlock?) {
		database.storePerson(person, success: success, failure: failure)
	}
}
