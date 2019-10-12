//
//  MoodSelectPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol MoodSelectViewProtocol: ViewProtocol {
	func setTitleText(_ text: String?)
	func setImageName(_ imageName: String)
	func selectPageNumber(_ pageNumber: Int, animated: Bool)
}

class MoodSelectPresenter {
	
	var viewProtocol: MoodSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var person: Person
	private let dataBase: HOBModelDatabaseProtocol
	
	init(person: Person, dataBase: HOBModelDatabaseProtocol) {
		self.person = person
		self.dataBase = dataBase
	}
	
	private func didSetViewProtocol() {
		viewProtocol?.setTitleText("\(person.name) is...")
		if let imageName = person.imageName {
			viewProtocol?.setImageName(imageName)
		}
		if person.moodStatus == .confused {
			viewProtocol?.selectPageNumber(0, animated: true)
		} else {
			viewProtocol?.selectPageNumber(1, animated: true)
		}
	}
}

// MARK: - Person Actions
extension MoodSelectPresenter {
	private func savePerson(_ person: Person) {
		viewProtocol?.showNetworkActivityIndicator(true)
		dataBase.storePerson(person, success: {
			print("successfully stored: \(person)")
			self.viewProtocol?.showNetworkActivityIndicator(false)
		}) { (error) in
			print("error: \(String(describing: error)) storing: \(person)")
			self.viewProtocol?.showNetworkActivityIndicator(false)
		}
	}
}

// MARK: - Exposed View Methods
extension MoodSelectPresenter {
	func onScrollViewDidEndDecelerating(page: Int) {
		let newMoodStatus = page == 0 ? MoodStatus.confused:MoodStatus.confusing
		person.moodStatus = newMoodStatus
	}
	
	func onViewWillDisappear() {
		savePerson(person)
	}
}
