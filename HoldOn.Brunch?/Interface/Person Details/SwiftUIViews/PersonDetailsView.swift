//
//  PersonDetailsView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import SwiftUI

struct PersonDetailsView: View {
	@ObservedObject var personDetails: PersonDetailsViewModel
	
    var body: some View {
		let placeholderText: String = "\(self.personDetails.name) said..."
		
		return VStack {
			PersonDetailsHeaderView(personDetails: personDetails)
				.padding([.leading, .trailing], 20)
				.padding([.top, .bottom], 10)
			
			EnterTextView(placeholderText: placeholderText, enteredText: $personDetails.enteredMessageText, isEnabled: $personDetails.isPostButtonEnabled, onButtonTap: {
				self.personDetails.onPostMessage?()
			})
				.padding([.leading, .trailing], 20)
			
			List(personDetails.messages.reversed()) { message in
				MessageCellView(message: message)
			}
			
			Spacer()
		}
    }
}

struct PersonDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
		let person = Person(name: "Baller", imageURLString: "cat", moodStatus: .confused)
		let personDetails = PersonDetailsViewModel(person: person)
		let message1 = Message(personId: person.id, created: Date(), text: "Message 1 text")
		let message2 = Message(personId: person.id, created: Date().addingTimeInterval(123), text: "Message 2 text")
		personDetails.messages = [message1, message2]
		return PersonDetailsView(personDetails: personDetails)
    }
}
