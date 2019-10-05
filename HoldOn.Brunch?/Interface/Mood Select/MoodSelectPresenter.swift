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
	
	var userState: UserState
	var viewProtocol: MoodSelectViewProtocol? { didSet { didSetViewProtocol() } }
	
	init(userState: UserState) {
		self.userState = userState
	}
	
	private func didSetViewProtocol() {
		viewProtocol?.setTitleText("Baller feels...")
	}
}

// MARK: - UserState Actions
extension MoodSelectPresenter {
	
}
