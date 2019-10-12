//
//  HOBFirebase.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/11/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Firebase
import Foundation

// MARK: - HOBFirebase
class HOBFirebase {
	
	private static let kPersonsCollectionPath = "persons"
	private static let database = Firestore.firestore()
	
	private static func getCollectionPathForCodable(_ codable: Codable) -> String {
		var collectionPath: String?
		if codable is Person {
			collectionPath = kPersonsCollectionPath
		}
		
		// If no matching Model type, return class name
		let className = String(describing: codable.self)
		
		return collectionPath ?? className
	}
	
	/// Retrieves the collectionPath from
	static func storeCodable(_ codable: Codable, success: (()->Void)?, failure: ((Error?)->Void)?) {
		guard let sureJSON = codable.toJSON() else {
			failure?(nil)
			return
		}
		
		let collectionPath = getCollectionPathForCodable(codable)
		database.collection(collectionPath).addDocument(data: sureJSON) { (error) in
			if error == nil {
				success?()
			} else {
				failure?(error)
			}
		}
	}
	
	static func retrieveAllOfPersons(success: @escaping ([Person])->Void, failure: ((Error?)->Void)?) {
		database.collection(kPersonsCollectionPath).getDocuments { (querySnapshot, error) in
			guard let sureQuerySnapshot = querySnapshot else {
				failure?(nil)
				return
			}
			// TODO: why does this incorrectly return false when `error` is `nil`???????????
//			guard error != nil else {
//				failure?(error)
//				return
//			}
			
			let documents = sureQuerySnapshot.documents
			var persons = [Person?]()
			documents.forEach({ (documentSnapshot) in
				let json = documentSnapshot.data()
				let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
				if let sureJSONData = jsonData {
					let person = try? JSONDecoder().decode(Person.self, from: sureJSONData)
					persons.append(person)
				}
			})
			let compactPersons = persons.compactMap({$0})
			success(compactPersons)
		}
	}
}


// MARK: - FirebaseStorable
protocol FirebaseStorable {
	func store()
}
extension FirebaseStorable {
	func store() {
		
	}
}
