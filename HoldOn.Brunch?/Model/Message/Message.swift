//
//  Message.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/26/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

struct Message: ModelProtocol, Identifiable {
	var id: String {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = .withInternetDateTime
		return dateFormatter.string(from: created)
	}
	
	let personId: String
	let created: Date
	let text: String
	
	var displayDate: String {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime]
		let displayDate = dateFormatter.string(from: created)
		return displayDate
	}
}
