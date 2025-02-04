//
//  AddPersonPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/6/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol AddPersonViewProtocol: ViewProtocol {
	func setTitle(_ title: String)
	func setUpLeftNavigationItem()
	func setUpRightNavigationItem()
	func enableRightNavigationItem(_ enable: Bool)
	func showImageSelectAlertController()
	func dismiss()
}

class AddPersonPresenter {
	var viewProtocol: AddPersonViewProtocol? { didSet { didSetViewProtocol() } }
	private let database: HOBModelDatabaseProtocol
	private let storage: HOBStorageProtocol
	
	private var name: String? // Expects no outside whitespace
	private var imageData: Data?
	private let moodStatus = MoodStatus.new
	
	init(database: HOBModelDatabaseProtocol = HOBModelDatabase.shared,
		 storage: HOBStorageProtocol = HOBStorage.shared) {
		self.database = database
		self.storage = storage
	}
	
	private func didSetViewProtocol() {
		viewProtocol?.setTitle("Add New Person")
		viewProtocol?.setUpLeftNavigationItem()
		viewProtocol?.setUpRightNavigationItem()
	}
}

// MARK: - Data Validation and Saving
extension AddPersonPresenter {
	private func isDataValid() -> Bool {
		guard let sureName = name, !sureName.isEmpty else {
			viewProtocol?.showOneButtonAlertModal(title: nil, message: "Please enter a name.")
			return false
		}
		
		return true
	}
	private func createNewPerson(imageURL: String?) -> Person? {
		guard let sureName = name else { return nil }
		
		let newPerson = PersonManager.createNewPerson(name: sureName, imageURL: imageURL, moodStatus: moodStatus)
		return newPerson
	}
	private func storeNewPerson(_ person: Person) {
		database.storePerson(person, success: {
			self.viewProtocol?.showActivityIndicator(false)
			self.viewProtocol?.dismiss()
		}) { (error) in
			self.viewProtocol?.showActivityIndicator(false)
			self.viewProtocol?.enableRightNavigationItem(true)
			self.viewProtocol?.showOneButtonAlertModal(title: nil, message: "Failed to save!")
		}
	}
	
	private func validateAndSave() {
		viewProtocol?.showActivityIndicator(true)
		viewProtocol?.enableRightNavigationItem(false)
		
		// Validate
		guard isDataValid() else {
			viewProtocol?.showActivityIndicator(false)
			viewProtocol?.enableRightNavigationItem(true)
			return
		}
		
		guard let sureNewPerson = createNewPerson(imageURL: nil) else {
			viewProtocol?.showActivityIndicator(false)
			viewProtocol?.enableRightNavigationItem(true)
			return
		}
		
		// Upload Image
		if let sureImageData = imageData {
			storage.storeImageData(sureImageData, filename: sureNewPerson.id, success: { (url) in
				self.storage.storeImageDataToCache(sureImageData, filename: sureNewPerson.id)
				
				var newPersonWithImageURL = sureNewPerson
				newPersonWithImageURL.imageURLString = url.absoluteString
				self.storeNewPerson(newPersonWithImageURL)
			}) { (error) in
				self.viewProtocol?.showOneButtonAlertModal(title: nil, message: "Failed to save!")
				self.viewProtocol?.showActivityIndicator(false)
				self.viewProtocol?.enableRightNavigationItem(true)
			}
		} else {
			storeNewPerson(sureNewPerson)
		}
	}
}


// MARK: - View Exposed Methods
extension AddPersonPresenter {
	func onCancelTapped() {
		viewProtocol?.dismiss()
	}
	func onSaveTapped(name: String?) {
		let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
		self.name = trimmedName
		
		validateAndSave()
	}
	func onSelectImageTapped() {
		viewProtocol?.showImageSelectAlertController()
	}
	func onNewImageSelected(_ imageData: Data?) {
		self.imageData = imageData
	}
}
