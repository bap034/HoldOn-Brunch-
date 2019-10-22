//
//  UIImage+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/21/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

extension UIImage {
	static func getLocalImageForFileName(_ filename: String) -> UIImage? {
		// Create local filesystem URL
		let localURL = URL(string: "images/\(filename + "png")")!
		
		let image = UIImage(contentsOfFile: localURL.absoluteString)
		return image
	}
}
