//
//  MessageReactionView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 2/2/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct MessageReactionView: View {
	var reactionType: MessageReactionType
	var reactionCount: Int
	
    var body: some View {
		HStack(spacing: 0) {
			if reactionCount > 0 {
				Text("\(reactionCount)")
			}
			
			Image(uiImage: UIImage(named: reactionType.getImageString())!) // TODO: remove forced unwrap
				.resizable()
				.scaledToFit()
		}
		.padding(5)
		.background(Color(.cyan))
		.cornerRadius(10)
    }
}

struct MessageReactionView_Previews: PreviewProvider {
    static var previews: some View {
		MessageReactionView(reactionType: .pizza, reactionCount: 103223)
    }
}
