//
//  MessageCellView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 1/8/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct MessageCellView: View {
	
	@ObservedObject var messageCellVM: MessageCellViewModel
	
	private var reactionTypes: [MessageReactionType] {
		guard let sureReactionTypes = messageCellVM.message.reactionTypes else { return [] }
		return Array(sureReactionTypes.keys.sorted())
	}
	
    var body: some View {
		VStack(spacing: 0) {
			HStack {
				VStack {
					Text(messageCellVM.message.displayDate)
						.font(.caption)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
						.foregroundColor(.gray)
					Text(messageCellVM.message.text)
						.font(.body)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
				}
				
				Spacer()
				
				if messageCellVM.message.reactionTypes == nil {
					Image(uiImage: UIImage(named: "icons8-kawaii-pizza-outline")!) // TODO: remove forced unwrap
						.resizable()
						.scaledToFit()
						.frame(maxWidth: 30, maxHeight: 30)
						.contextMenu {
							MessageReactionContextMenuView(messageCellVM: messageCellVM)
					}
				}
			}
			
			if !reactionTypes.isEmpty {
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 5) {
						ForEach(reactionTypes) { reactionType in
							MessageReactionView(reactionType: reactionType, reactionCount: self.messageCellVM.getCountForReactionType(reactionType))
								.frame(maxHeight: 30)
								.padding(2)
						}
					}
				}
			}
		}
	}
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
		var message = Message(personId: "Baller", created: Date(), text: "Message text")
		message.reactionTypes = [.pizza : 20, .iceCream : 5, .bread:1, .coffee:1, .cupcake:1, .egg:1, .frenchFries:1, .pumpkin:1, .soda:1, .steak:1, .sushi:1, .taco:1]
//		message.reactionTypes = [.pizza : 20]
		let messageCellVM = MessageCellViewModel(message: message)
		messageCellVM.onReactionTap = { reactionType in
			print("button pressed")
		}
		return MessageCellView(messageCellVM: messageCellVM)
    }
}
