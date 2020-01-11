//
//  MessageManager.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/26/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

class MessageManager {
	// MARK: - Creation
	static func createNewMessage(personId: String, created: Date = Date(), text: String) -> Message {
		let newMessage = Message(personId: personId, created: created, text: text)
		return newMessage
	}
	
	// MARK: - HOBModelDatabaseProtocol
	static func storeMessage(_ message: Message, database: HOBModelDatabaseProtocol = HOBModelDatabase.shared, success: StoreSuccessBlock?, failure: FailureBlock?) {
		database.storeMessage(message, success: success, failure: failure)
	}
}
