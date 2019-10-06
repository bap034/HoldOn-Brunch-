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
}

class MoodSelectPresenter {
	
	var viewProtocol: MoodSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private let person: Person
	
	init(person: Person) {
		self.person = person
	}
	
	private func didSetViewProtocol() {
		viewProtocol?.setTitleText("Baller is...")
	}
}

// MARK: - Person Actions
extension MoodSelectPresenter {
	
}
