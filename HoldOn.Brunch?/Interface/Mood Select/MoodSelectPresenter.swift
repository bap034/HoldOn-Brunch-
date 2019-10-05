//
//  MoodSelectPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol MainViewProtocol {
	
}

class MoodSelectPresenter {
	
	var userState: UserState
	var viewProtocol: MainViewProtocol? { didSet { didSetViewProtocol() } }
	
	init(userState: UserState) {
		self.userState = userState
	}
	
	private func didSetViewProtocol() {
		
	}
}

// MARK: - UserState Actions
extension MoodSelectPresenter {
	
}
