//
//  UIButton+MH.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/6/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

extension UIButton {
	func setBackgroundColor(_ color:UIColor, forState state:UIControl.State) {
		let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		
		context?.setFillColor(color.cgColor)
		context?.fill(rect)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.setBackgroundImage(image, for: state)
	}
	
	func add(_ block: @escaping ()->(), for controlEvents: UIControl.Event) {
		let sleeve = BlockSleeve(block: block)
		self.addTarget(sleeve, action: #selector(sleeve.invoke), for: controlEvents)
		objc_setAssociatedObject(self, String("\(arc4random())"), sleeve, .OBJC_ASSOCIATION_RETAIN)
	}
	
	func cleanAdd(_ block: @escaping ()->(), for controlEvents: UIControl.Event) {
		// NOTE: the cleaning process - remove all actions in all previous targets
		for target in self.allTargets {
			self.removeTarget(target, action: nil, for: controlEvents)
		}
		
		self.add(block, for: controlEvents)
	}
}

private class BlockSleeve: NSObject {
	private let block: ()->()
	
	init(block: @escaping ()->()) {
		self.block = block
		super.init()
	}
	
	@objc func invoke() {
		block()
	}
}

