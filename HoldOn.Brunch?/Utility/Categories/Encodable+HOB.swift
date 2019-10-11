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
		guard let jsonData = try? JSONEncoder().encode(self) else { return nil }
		let jsonString = String(data: jsonData, encoding: .utf8)
		return jsonString
	}
}
