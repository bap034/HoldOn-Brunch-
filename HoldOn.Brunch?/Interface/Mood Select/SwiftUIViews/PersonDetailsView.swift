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
	
    var body: some View {
		VStack {
			PersonDetailsHeaderView(personDetails: _personDetails)
				.padding(20)
			
			Spacer()
		}
    }
}

struct PersonDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
		PersonDetailsView().environmentObject(PersonDetails(person: Person(name: "Baller", imageURLString: "cat", moodStatus: .confused)))
    }
}
