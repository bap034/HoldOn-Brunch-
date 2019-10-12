//
//  Encodable+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/10/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

extension Encodable {
	func toJSONString() -> String? {
		guard let jsonData = toJSONData() else { return nil }
		let jsonString = String(data: jsonData, encoding: .utf8)
		return jsonString
	}
	func toJSONData() -> Data? {
		let jsonData = try? JSONEncoder().encode(self)
		return jsonData
	}
	func toJSON() -> [String: Any]? {
		guard let jsonData = toJSONData() else { return nil }
		
		let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
		return json
	}
}
