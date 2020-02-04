//
//  MessageReactionContextMenuView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 2/3/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct MessageReactionContextMenuView: View {
	
	@ObservedObject var messageCellVM: MessageCellViewModel
	
    var body: some View {
		
		ForEach(MessageReactionType.allCases) { reactionType in
			Button(action: {
				self.messageCellVM.incrementCountForReactionType(reactionType)
				self.messageCellVM.onReactionTap?(self.messageCellVM.message)
			}) {
				Text(reactionType.rawValue)
				Image(uiImage: UIImage(named: reactionType.getImageString())!)
					.renderingMode(.original)
			}
		}
    }
}

struct MessageReactionContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
		var message = Message(personId: "Baller", created: Date(), text: "Message text")
		message.reactionTypes = [.pizza : 2, .iceCream : 5]
		let messageCellVM = MessageCellViewModel(message: message)
		return MessageReactionContextMenuView(messageCellVM: messageCellVM)
    }
}
