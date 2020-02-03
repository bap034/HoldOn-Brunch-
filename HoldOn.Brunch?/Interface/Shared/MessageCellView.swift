//
//  MessageCellView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 1/8/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct MessageCellView: View {
	
	var message: Message
	var sureMessageReactionTypes: [MessageReactionType] {
		let reactionTypes = message.reactionTypes ?? []
		return reactionTypes
	}
	
    var body: some View {
		VStack(spacing: 0) {
			HStack {
				VStack {
					Text(message.displayDate)
						.font(.caption)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
						.foregroundColor(.gray)
					Text(message.text)
						.font(.body)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
				}
				
				Spacer()
				
				Image("icons8-kawaii-pizza-outline")
					.resizable()
					.scaledToFit()
					.frame(width: 50, height: 50)
			}
			
			if !sureMessageReactionTypes.isEmpty {
				HStack(spacing: 0) {
					Spacer()
					
					ForEach(sureMessageReactionTypes) { reactionType in
						Image(reactionType.getImageString())
							.resizable()
							.scaledToFit()
							.frame(maxWidth: 30, maxHeight: 30)
					}
				}
			}
		}
	}
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
		var message = Message(personId: "Baller", created: Date(), text: "Message text")
		message.reactionTypes = [.pizza, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream, .iceCream]
		return MessageCellView(message: message)
    }
}
