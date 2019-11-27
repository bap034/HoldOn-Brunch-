//
//  Message.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/26/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

struct Message: ModelProtocol {
	var id: String { return ISO8601DateFormatter().string(from: created) }
	
	let personId: String
	let created: Date
	let text: String
}
