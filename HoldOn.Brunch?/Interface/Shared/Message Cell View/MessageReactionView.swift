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
					.padding(.leading, 3)
			}
			
			Image(uiImage: UIImage(named: reactionType.getImageString())!) // TODO: remove forced unwrap
				.resizable()
				.scaledToFit()
			.padding(3)
		}
		.overlay(
			RoundedRectangle(cornerRadius: 4)
				.stroke(Color(Themes.Default.color), lineWidth: 2)
		)
    }
}

struct MessageReactionView_Previews: PreviewProvider {
    static var previews: some View {
		MessageReactionView(reactionType: .soda, reactionCount: 10)
			.frame(maxWidth: 50, maxHeight: 30)
    }
}
