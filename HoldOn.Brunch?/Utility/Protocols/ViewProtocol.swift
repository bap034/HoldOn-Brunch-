//
//  ViewProtocol.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/12/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation
import UIKit

protocol ViewProtocol {}
extension ViewProtocol {
	func showNetworkActivityIndicator(_ show: Bool) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = show
	}
}
