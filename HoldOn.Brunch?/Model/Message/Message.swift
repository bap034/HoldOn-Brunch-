//
//  Message.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/26/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

enum MessageReactionType: String, Codable, Identifiable {
	case bread
	case coffee
	case cupcake
	case egg
	case frenchFries
	case iceCream
	case pizza
	case pumpkin
	case soda
	case steak
	case sushi
	case taco
	
	var id: String { return rawValue }
	
	func getImageString() -> String {
		let imageString: String
		
		switch self {
		case .bread:
			imageString = "icons8-kawaii-bread"
		case .coffee:
			imageString = "icons8-kawaii-coffee"
		case .cupcake:
			imageString = "icons8-kawaii-cupcake"
		case .egg:
			imageString = "icons8-kawaii-egg"
		case .frenchFries:
			imageString = "icons8-kawaii-french-fries"
		case .iceCream:
			imageString = "icons8-kawaii-ice-cream"
		case .pizza:
			imageString = "icons8-kawaii-pizza"
		case .pumpkin:
			imageString = "icons8-kawaii-pumpkin"
		case .soda:
			imageString = "icons8-kawaii-soda"
		case .steak:
			imageString = "icons8-kawaii-steak"
		case .sushi:
			imageString = "icons8-kawaii-sushi"
		case .taco:
			imageString = "icons8-kawaii-taco"
		}
		
		return imageString
	}
}

struct Message: ModelProtocol, Identifiable {
	var id: String {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = .withInternetDateTime
		return dateFormatter.string(from: created)
	}
	
	let personId: String
	let created: Date
	let text: String
	var reactionTypes: [MessageReactionType]? = nil
	
	var displayDate: String {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime]
		let displayDate = dateFormatter.string(from: created)
		return displayDate
	}
}
