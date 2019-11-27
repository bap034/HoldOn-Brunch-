//
//  PersonDetailsPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol MoodSelectViewProtocol: ViewProtocol {
	func setPerson(_ person: Person)
	func updatePersonImageData(_ data: Data)
	func setPostButtonEnabled(_ enabled: Bool)
}

class PersonDetailsPresenter {
	
	var viewProtocol: MoodSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var person: Person
	private let database: HOBModelDatabaseProtocol
	internal let storage: HOBStorageProtocol
	
	init(person: Person, database: HOBModelDatabaseProtocol, storage: HOBStorageProtocol) {
		self.person = person
		self.database = database
		self.storage = storage
	}
	
	private func didSetViewProtocol() {
		viewProtocol?.setPerson(person)
	}
}

// MARK: - Person Actions
extension PersonDetailsPresenter {
	private func savePerson(_ person: Person) {
		viewProtocol?.showNetworkActivityIndicator(true)
		database.storePerson(person, success: {
			print("successfully stored: \(person)")
			self.viewProtocol?.showNetworkActivityIndicator(false)
		}) { (error) in
			print("error: \(String(describing: error)) storing: \(person)")
			self.viewProtocol?.showNetworkActivityIndicator(false)
		}
	}
}

// MARK: - Exposed View Methods
extension PersonDetailsPresenter {
	func onViewWillDisappear(newDetails: PersonDetails) {
		person.name = newDetails.name
		person.moodStatus = newDetails.moodStatus
		savePerson(person)
	}
	
	func onPostMessageButtonTapped(messageText: String) {
		viewProtocol?.setPostButtonEnabled(false)
		let message = MessageManager.createNewMessage(personId: person.id, text: messageText)
		database.storeMessage(message, success: {
			self.viewProtocol?.setPostButtonEnabled(true)
//			viewProtocol?.reloadMessageTable()
		}) { (error) in
			self.viewProtocol?.setPostButtonEnabled(true)
			self.viewProtocol?.showOneButtonAlertModal(title: "Oops", message: error?.localizedDescription)
		}
	}
}

// MARK: - PersonImageRetrievablePresenterProtocol
extension PersonDetailsPresenter: PersonImageRetrievablePresenterProtocol {
	func onImageDataComplete(cachedData: Data?) {
		if let sureCachedData = cachedData {
			self.viewProtocol?.updatePersonImageData(sureCachedData)
		}
	}
}
