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
	private let dataBase: HOBModelDatabaseProtocol
	
	private var name: String? // Expects no outside whitespace
	private var imageName: String?
	private let moodStatus = MoodStatus.new
	
	init(dataBase: HOBModelDatabaseProtocol = HOBModelDatabase.shared) {
		self.dataBase = dataBase
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
	private func createNewPerson() -> Person? {
		guard let sureName = name else { return nil }
		
		let newPerson = Person(name: sureName, imageName: imageName, moodStatus: moodStatus)
		return newPerson
	}
	
	private func validateAndSave() {
		viewProtocol?.enableRightNavigationItem(false)
		
		guard isDataValid() else {
			viewProtocol?.enableRightNavigationItem(true)
			return
		}
		
		guard let sureNewPerson = createNewPerson() else {
			viewProtocol?.enableRightNavigationItem(true)
			return
		}
		
		dataBase.storePerson(sureNewPerson, success: {
			self.viewProtocol?.dismiss()
		}) { (error) in
			self.viewProtocol?.enableRightNavigationItem(true)
			// TODO: inform user, "could not save Person"
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
		// TODO: store data?
	}
}
