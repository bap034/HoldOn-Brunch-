//
//  MoodSelectPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol MoodSelectViewProtocol {
	func setTitleText(_ text: String?)
	func setImageName(_ imageName: String)
}

class MoodSelectPresenter {
	
	var viewProtocol: MoodSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var person: Person
	
	init(person: Person) {
		self.person = person
	}
	
	private func didSetViewProtocol() {
		viewProtocol?.setTitleText("\(person.name) is...")
		if let imageName = person.imageName {
			viewProtocol?.setImageName(imageName)
		}
	}
}

// MARK: - Person Actions
extension MoodSelectPresenter {
	
}

// MARK: - Exposed View Methods
extension MoodSelectPresenter {
	func onScrollViewDidEndDecelerating(page: Int) {
		let newMoodStatus = page == 0 ? MoodStatus.confused:MoodStatus.confusing
		person.moodStatus = newMoodStatus
		// TODO: finish persisting data
	}
}
