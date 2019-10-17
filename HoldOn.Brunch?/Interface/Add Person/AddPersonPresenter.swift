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
	func setUpLeftNavigationItem(title: String, action: ()->Void)
	func setUpRightNavigationItem(title: String, action: ()->Void)
	func enableRightNavigationItem(_ enable: Bool)
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
		viewProtocol?.setUpLeftNavigationItem(title: "Cancel", action: onLeftNavigationItemTapped)
		viewProtocol?.setUpRightNavigationItem(title: "Save", action: onRightNavigationItemTapped)
	}
}

// MARK: - Data Validation and Saving
extension AddPersonPresenter {
	private func isDataValid() -> Bool {
		guard let sureName = name, !sureName.isEmpty else {
			// TODO: inform user name is not valid
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
	@objc func onLeftNavigationItemTapped() {
		viewProtocol?.dismiss()
	}
	@objc func onRightNavigationItemTapped() {
		validateAndSave()
	}
}
