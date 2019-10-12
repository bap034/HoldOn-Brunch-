//
//  IntroPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/6/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol IntroViewProtocol {
	func setTitleText(_ text: String)
	func setImageName(_ imageName: String)
	func pushPersonSelectVC(persons: [Person])
}

class IntroPresenter {
	
	var viewProtocol: IntroViewProtocol? { didSet { didSetViewProtocol() } }
	
	func didSetViewProtocol() {
		viewProtocol?.setTitleText("Hold On.")
		viewProtocol?.setImageName("brunch")
	}
}

// MARK: - View Exposed Methods
extension IntroPresenter {
	func onButtonTapped() {
		HOBFirebase.retrieveAllOfPersons(success: { (persons) in
			self.viewProtocol?.pushPersonSelectVC(persons: persons)
		}, failure: nil)
	}
}
