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
	
    var body: some View {
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
		}
	}
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
		let message = Message(personId: "Baller", created: Date(), text: "Message text")
		return MessageCellView(message: message)
    }
}
