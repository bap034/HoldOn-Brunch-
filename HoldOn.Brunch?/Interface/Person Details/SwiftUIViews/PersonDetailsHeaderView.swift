//
//  PersonDetailsHeaderView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/21/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import SwiftUI

struct PersonDetailsHeaderView: View {
	@ObservedObject var personDetails: PersonDetailsViewModel
	
    var body: some View {
		// Container
		HStack(spacing: 20) {
			
			Image(uiImage: personDetails.image ?? UIImage())
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 4))
				.shadow(radius: 10)
				.overlay(
					RoundedRectangle(cornerRadius: 4).stroke(Color(.black), lineWidth: 1))
				.frame(width: 100, height: 100)
			
			VStack(spacing: 20) {
				// Text and Buttons Container
				VStack {
					Text(personDetails.name + " is...")
						.font(.title)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
						.lineLimit(2)
						.allowsTightening(true)
					
					// Buttons Container
					TwoTextButtonSelectView(personDetails: personDetails)
						.frame(height: 40)
				}
				
			}
			.padding([.top, .bottom], 5)
			.overlay(
				RoundedRectangle(cornerRadius: 4).stroke(Color(.clear), lineWidth: 2)
			)
		}
	}
}

struct TwoTextButtonSelectView: View {
	var option1 = MoodStatus.confused
	var option2 = MoodStatus.confusing
	@ObservedObject var personDetails: PersonDetailsViewModel
	
	var body: some View {
	
	// Buttons Container
		HStack(spacing:0) {
			
			Button(action: {
				print("Button 1 pressed")
				self.personDetails.moodStatus = self.option1
			}) {
				Text(option1.rawValue.capitalized)
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
				.foregroundColor(.black)
			.background(Color(personDetails.moodStatus == option1 ? .cyan:.white))
				.onTapGesture {
					print("Tapped!")
			}
			
			// Divider
			Rectangle()
				.background(Color(.black))
				.frame(width: 1)
			
			Button(action: {
				print("Button 2 pressed")
				self.personDetails.moodStatus = self.option2
			}) {
				Text(option2.rawValue.capitalized)
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
			.foregroundColor(.black)
			.background(Color(personDetails.moodStatus == option2 ? .cyan:.white))
		}
		.overlay(
			RoundedRectangle(cornerRadius: 4).stroke(Color(.black), lineWidth: 1)
		)
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
	}
}

struct PersonDetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
		PersonDetailsHeaderView(personDetails: PersonDetailsViewModel(person: Person(name: "Baller", imageURLString: "cat", moodStatus: .confused)))
    }
}
