//
//  HOBFirebaseStorage.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/21/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import FirebaseStorage
import Foundation

protocol HOBStorageProtocol {
	func storeImageData(_ data: Data, filename: String, success: @escaping (URL)->Void, failure: ((Error?)->Void)?)
	func downloadImageDataToCache(filename: String, success: @escaping ()->Void, failure: ((Error?)->Void)?)
	func retrieveImageDataFromCache(filename: String) -> Data?
}

class HOBStorage: HOBStorageProtocol {
	static let shared = HOBStorage()
	
	private let imageReference =  Storage.storage().reference().child("images")
	
	func storeImageData(_ data: Data, filename: String, success: @escaping (URL)->Void, failure: ((Error?)->Void)?) {
		let newReference = imageReference.child(filename.appendPNGExtension())
		let metadata = StorageMetadata()
		metadata.contentType = "image/png"
		
		newReference.putData(data, metadata: metadata) { (responseMetaData, error) in
			guard let sureResponseMetaData = responseMetaData else {
				failure?(error)
				return
			}
			guard sureResponseMetaData.contentType == "image/png" else {
				failure?(nil)
				return
			}
			
			newReference.downloadURL { (url, error) in
				guard let downloadURL = url else {
					failure?(error)
					return
				}
				
				success(downloadURL)
			}
		}
	}
	
	func downloadImageDataToCache(filename: String, success: @escaping ()->Void, failure: ((Error?)->Void)?) {
		let downloadReference = imageReference.child(filename.appendPNGExtension())
		
		guard let localURL = getLocalImageURL(filename: filename) else {
			failure?(nil)
			return
		}
				
		// Download to the local filesystem
		downloadReference.write(toFile: localURL) { newLocalURL, error in
			if newLocalURL != nil {
				success()
			} else {
				failure?(error)
			}
		}
	}
	
	func retrieveImageDataFromCache(filename: String) -> Data? {
		guard let localURL = getLocalImageURL(filename: filename) else { return nil }

		let data = try? Data(contentsOf: localURL)
		return data
	}
}

// MARK: - Helper Methods
extension HOBStorage {
	private func getLocalImageURL(filename: String) -> URL? {
		let fileManager = FileManager.default
		guard let documentsURL = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
		
		let imagesDirectory = documentsURL.appendingPathComponent("images", isDirectory: true)
		let imageFile = imagesDirectory.appendingPathComponent(filename.appendPNGExtension())
		
		return imageFile
	}
}
