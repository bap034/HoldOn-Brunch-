//
//  ViewProtocol.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/12/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation
import UIKit

protocol ViewProtocol: UIViewController {}
extension ViewProtocol {
	func showNetworkActivityIndicator(_ show: Bool) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = show
	}
	
	func showTwoButtonAlertModal(title: String?,
								 message: String?,
								 leftButtonTitle: String = "Ok",
								 rightButtonTitle: String = "Cancel",
								 onLeftButtonTapped: (()->Void)?) {
		let alertModal = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let goToSettingsAction = UIAlertAction(title: leftButtonTitle, style: .default) { (action) in
			onLeftButtonTapped?()
		}
		let cancelAction = UIAlertAction(title: rightButtonTitle, style: .cancel, handler: nil)
		alertModal.addAction(goToSettingsAction)
		alertModal.addAction(cancelAction)
		self.present(alertModal, animated: true, completion: nil)
	}
}
