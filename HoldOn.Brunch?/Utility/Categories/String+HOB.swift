//
//  String+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/10/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

extension String {
	func toDecodable<T:Decodable>() -> T? {
		guard let jsonData = self.data(using: .utf8) else { return nil }
		let decodable = try? JSONDecoder().decode(T.self, from: jsonData)
		return decodable
	}
	
	func appendPNGExtension() -> String {
		let stringWithPNGExtension = self + ".png"
		return stringWithPNGExtension
	}
}
