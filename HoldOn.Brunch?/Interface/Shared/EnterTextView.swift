//
//  EnterTextView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/26/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import SwiftUI

struct EnterTextView: View {
	
	let placeholderText: String
	@Binding var enteredText: String
	@Binding var isEnabled: Bool
	var onButtonTap: (()->Void)?
	
    var body: some View {
		HStack() {
			TextField(placeholderText, text: $enteredText)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			
			Button(action: {
				UIApplication.shared.endEditing()
				self.onButtonTap?()
				self.enteredText = ""
			}) {
				Text("Post")
					.foregroundColor(Color.purple)
			}
			.padding([.leading], 10)
			.disabled(!isEnabled)
		}
    }
}

struct EnterTextView_Previews: PreviewProvider {
	@State static var textExample = ""
	@State static var isButtonEnabled = true
	
	static var previews: some View {
		var view = EnterTextView(placeholderText: "Baller said...", enteredText: $textExample, isEnabled: $isButtonEnabled)
		view.onButtonTap = {
			print("send message: \(textExample)")
		}
		return view
    }
}
