//
//  View+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import SwiftUI

extension View {
	func toUIView() -> UIView {
		let hostingController = toUIViewController()
		let uiView = hostingController.view
		return uiView ?? UIView()
	}
	func toUIViewController() -> UIViewController {
		let hostingController = UIHostingController(rootView: self)
		return hostingController
	}
}
