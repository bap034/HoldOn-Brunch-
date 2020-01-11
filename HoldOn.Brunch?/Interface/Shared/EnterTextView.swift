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
			}
			.padding()
		}
    }
}

struct EnterTextView_Previews: PreviewProvider {
	@State static var textExample = ""
	
	static var previews: some View {
		var view = EnterTextView(placeholderText: "Baller said...", enteredText: $textExample)
		view.onButtonTap = {
			print("send message: \(textExample)")
		}
		return view
    }
}
