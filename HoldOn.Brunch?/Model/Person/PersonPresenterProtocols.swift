//
//  PersonPresenterProtocols.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol PersonImageRetrievablePresenterProtocol {
	var storage: HOBStorageProtocol { get }
	
	func retrieveImageDataForPerson(_ person: Person)
	func onImageDataComplete(person: Person, cachedData: Data?)
}

extension PersonImageRetrievablePresenterProtocol {
	func retrieveImageDataForPerson(_ person: Person) {
		PersonManager.getImageDataForPerson(person, storage: storage) { (cachedData) in
			self.onImageDataComplete(person: person, cachedData: cachedData)
		}
	}
}
