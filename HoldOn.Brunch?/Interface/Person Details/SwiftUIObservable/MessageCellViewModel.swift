//
//  MessageCellViewModel.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 2/3/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class MessageCellViewModel: ObservableObject, Identifiable {
	var id: String { return message.id }
	
	@Published var message: Message
	
	var onReactionTap: ((Message)->Void)?
	
	init(message: Message) {
		self.message = message
	}
}


// MARK: - Helper Functions
extension MessageCellViewModel {
	func getCountForReactionType(_ reactionType: MessageReactionType) -> Int {
		let count = message.reactionTypes?[reactionType] ?? 0
		return count
	}
	
	func incrementCountForReactionType(_ reactionType: MessageReactionType) {
		let newCount = getCountForReactionType(reactionType) + 1
		
		if message.reactionTypes != nil {
			message.reactionTypes?[reactionType] = newCount
		} else {
			message.reactionTypes = [reactionType:newCount]
		}
	}
}
