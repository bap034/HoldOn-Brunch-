//
//  PersonDetailsView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import SwiftUI

struct PersonDetailsView: View {
	@EnvironmentObject var personDetails: PersonDetails
	@State private var enteredText = ""
	var onPostMessage: ((String)->Void)?
	
    var body: some View {
		let placeholderText: String = "\(self.personDetails.name) said..."
		
		return VStack {
			PersonDetailsHeaderView(personDetails: _personDetails)
				.padding(20)
			
			EnterTextView(placeholderText: placeholderText, enteredText: $enteredText, onButtonTap: {
				self.onPostMessage?(self.enteredText)
			})
				.padding([.leading, .trailing], 20)
			
			Spacer()
		}
    }
}

struct PersonDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
		PersonDetailsView().environmentObject(PersonDetails(person: Person(name: "Baller", imageURLString: "cat", moodStatus: .confused)))
    }
}
