//
//  UIView+BAP.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

extension UIView {
	func activateConstraintsToPerimeter(ofParentView parentView: UIView, constant: CGFloat = 0) {
		topAnchor.constraint(equalTo: parentView.topAnchor, constant: constant).isActive = true
		bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: constant).isActive = true
		leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: constant).isActive = true
		rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: constant).isActive = true
	}
}
