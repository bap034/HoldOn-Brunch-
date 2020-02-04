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
		return Array(sureReactionTypes.keys)
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
				
				Button(action: {
					self.messageCellVM.onReactionTap?()
				}) {
					Image(uiImage: UIImage(named: "icons8-kawaii-pizza-outline")!) // TODO: remove forced unwrap
						.resizable()
						.scaledToFit()
						.frame(maxWidth: 30, maxHeight: 30)
						.colorMultiply(.black)
				}
			}
			
			if !reactionTypes.isEmpty {
				HStack(spacing: 0) {
					Spacer()
					
					ForEach(reactionTypes) { reactionType in
						MessageReactionView(reactionType: reactionType, reactionCount: self.messageCellVM.getCountForReactionType(reactionType))
							.frame(maxHeight: 30)
							.padding([.leading], 5)
					}
				}
			}
		}
	}
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
		var message = Message(personId: "Baller", created: Date(), text: "Message text")
		message.reactionTypes = [.pizza : 2, .iceCream : 5]
		let messageCellVM = MessageCellViewModel(message: message)
		messageCellVM.onReactionTap = {
			print("button pressed")
		}
		return MessageCellView(messageCellVM: messageCellVM)
    }
}
