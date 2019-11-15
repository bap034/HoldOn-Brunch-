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
	
	func getImageDataForPerson(_ person: Person) -> Data?
	func onImageDataComplete(cachedData: Data?)
}

extension PersonImageRetrievablePresenterProtocol {
	func getImageDataForPerson(_ person: Person) -> Data? {
		let data = PersonManager.getImageDataForPerson(person, storage: storage) { (cachedData) in
			self.onImageDataComplete(cachedData: cachedData)
		}
		return data
	}
}
