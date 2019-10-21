//
//  PhotosManager.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/20/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation
import Photos

class PhotosManager {
	static func getPhotoLibraryAuthorization(onAuthorized:(()->Void)?, onDenied:(()->Void)?) {
		let authStatus = PHPhotoLibrary.authorizationStatus()
		if authStatus == .authorized {
			onAuthorized?()
		} else if authStatus == .notDetermined {
			PHPhotoLibrary.requestAuthorization({ (authorizationStatus) in
				if authorizationStatus == .authorized {
					DispatchQueue.main.async { // requestAuthorization() comes back on non main thread
						onAuthorized?()
					}
				}
			})
		} else {
			onDenied?()
		}
	}
}
