//
//  PersonDetailsPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol PersonDetailsViewProtocol: ViewProtocol {
	func setPerson(_ person: Person)
	func updatePersonImageData(_ data: Data)
	func setPostButtonEnabled(_ enabled: Bool)
	func updateMessagesTable()
}

class PersonDetailsPresenter {
	
	var viewProtocol: PersonDetailsViewProtocol? { didSet { didSetViewProtocol() } }
	private var person: Person
	private var messages = [Message]()
	private let database: HOBModelDatabaseProtocol
	internal let storage: HOBStorageProtocol
	
	init(person: Person, database: HOBModelDatabaseProtocol, storage: HOBStorageProtocol) {
		self.person = person
		self.database = database
		self.storage = storage
	}
	
	private func didSetViewProtocol() {
		PersonManager.getAllMessagesForPerson(person, database: database, success: { (messages) in
			self.messages = messages
			self.viewProtocol?.setPerson(self.person)
		}) { (error) in
			let errorDescription = error?.localizedDescription ?? "nil error"
			print("failed to get messages for \(self.person.name): \(errorDescription)")
		}
	}
}

// MARK: - Person Actions
extension PersonDetailsPresenter {
	private func savePerson(_ person: Person) {
		viewProtocol?.showActivityIndicator(true)
		PersonManager.storePerson(person, database: database, success: {
			print("successfully stored: \(person)")
			self.viewProtocol?.showActivityIndicator(false)
		}) { (error) in
			print("error: \(String(describing: error)) storing: \(person)")
			self.viewProtocol?.showActivityIndicator(false)
		}
	}
}

// MARK: - Exposed View Methods
extension PersonDetailsPresenter {
	func onViewWillDisappear(newDetails: PersonDetailsViewModel) {
		guard (person.name != newDetails.name || person.moodStatus != newDetails.moodStatus) else { return }
		
		person.name = newDetails.name
		person.moodStatus = newDetails.moodStatus
		savePerson(person)
	}
	
	func onPostMessageButtonTapped(messageText: String) {
		let trimmedMessageText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
		guard !trimmedMessageText.isEmpty else { return }
		
		viewProtocol?.setPostButtonEnabled(false)
		
		let message = MessageManager.createNewMessage(personId: person.id, text: trimmedMessageText)
		MessageManager.storeMessage(message, database: database, success: {
			self.viewProtocol?.setPostButtonEnabled(true)
			PersonManager.getAllMessagesForPerson(self.person, database: self.database, success: { (messages) in
				self.messages = messages
				self.viewProtocol?.updateMessagesTable()
			}, failure: nil)
		}) { (error) in
			self.viewProtocol?.setPostButtonEnabled(true)
			self.viewProtocol?.showOneButtonAlertModal(title: "Oops", message: error?.localizedDescription)
		}
	}
	
	func onGetMessageCellVMs() -> [MessageCellViewModel] {
		var messageCellVMs = [MessageCellViewModel]()
		messages.forEach { (message) in
			let messageCellVM = MessageCellViewModel(message: message)
			messageCellVM.onReactionTap = {
				self.onMessageReactionTap(messageId: message.id)
			}
			messageCellVMs.append(messageCellVM)
		}
		return messageCellVMs
	}
	
	func onMessageReactionTap(messageId: String) {
		print("***** messageId: \(messageId) reaction button tapped")
	}
}

// MARK: - PersonImageRetrievablePresenterProtocol
extension PersonDetailsPresenter: PersonImageRetrievablePresenterProtocol {
	func onImageDataComplete(person:Person, cachedData: Data?) {
		if let sureCachedData = cachedData {
			self.viewProtocol?.updatePersonImageData(sureCachedData)
		}
	}
}
