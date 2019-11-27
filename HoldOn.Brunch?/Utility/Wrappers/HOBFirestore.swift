//
//  HOBFirestore.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/11/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Firebase
import Foundation

typealias StoreSuccessBlock = ()->Void
typealias RetrieveSuccessBlock<T> = ([T])->Void
typealias FailureBlock = (Error?)->Void

// MARK: - HOBModelDatabase
protocol HOBModelDatabaseProtocol {
	func storePerson(_ person: Person, success: StoreSuccessBlock?, failure: FailureBlock?)
	func getAllPersons(success: @escaping RetrieveSuccessBlock<Person>, failure: FailureBlock?)
}
class HOBModelDatabase: HOBModelDatabaseProtocol {
	
	static let shared = HOBModelDatabase(database: Firestore.firestore())
	private let database: HOBDatabaseProtocol
	
	private init(database: HOBDatabaseProtocol) {
		self.database = database
	}

	// MARK: Person
	private let personsCollectionPath = "persons"
	func storePerson(_ person: Person, success: StoreSuccessBlock?, failure: FailureBlock?) {
		database.storeEncodable(person, destinationPath: personsCollectionPath, success: success, failure: failure)
	}
	func getAllPersons(success: @escaping RetrieveSuccessBlock<Person>, failure: FailureBlock?) {
		database.retrieveAllDecodable(destinationPath: personsCollectionPath, success: { (persons) in
			success(persons)
		}, failure: failure)
	}
}


// MARK: - HOBDatabaseProtocol
protocol HOBDatabaseProtocol {
	func storeEncodable(_ encodable: ModelProtocol, destinationPath: String, success: StoreSuccessBlock?, failure: FailureBlock?)
	func retrieveAllDecodable<T:Decodable>(destinationPath: String, success: @escaping RetrieveSuccessBlock<T>, failure: FailureBlock?)
}
extension Firestore: HOBDatabaseProtocol {
	func storeEncodable(_ encodable: ModelProtocol, destinationPath: String, success: StoreSuccessBlock?, failure: FailureBlock?) {
		guard let sureJSON = encodable.toJSON() else {
			failure?(nil)
			return
		}
		
		let document = collection(destinationPath).document(encodable.id)
		document.setData(sureJSON) { (error) in // `setData()` creates a new entry if the reference doesn't exist
			if error == nil {
				success?()
			} else {
				failure?(error)
			}
		}
	}
	
	func retrieveAllDecodable<T>(destinationPath: String, success: @escaping RetrieveSuccessBlock<T>, failure: FailureBlock?) where T : Decodable {
		collection(destinationPath).getDocuments { (querySnapshot, error) in
			guard let sureQuerySnapshot = querySnapshot else {
				failure?(nil)
				return
			}
			guard error == nil else {
				failure?(error)
				return
			}
			
			let documents = sureQuerySnapshot.documents
			var codables = [T?]()
			documents.forEach({ (documentSnapshot) in
				let json = documentSnapshot.data()
				let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
				if let sureJSONData = jsonData {
					let codable = try? JSONDecoder().decode(T.self, from: sureJSONData)
					codables.append(codable)
				}
			})
			let compactCodables = codables.compactMap({$0})
			success(compactCodables)
		}
	}
}
