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
//		if show {
//			let activityIndicator = UIActivityIndicatorView(style: .medium)
//			activityIndicator.startAnimating()
//			activityIndicator.accessibilityLabel = "networkActivityIndicator"
//			self.view.insertSubview(activityIndicator, at: 0)
//		} else {
//			let activityIndicator = self.view.subviews.first(where: { $0.accessibilityLabel == "networkActivityIndicator" })
//			guard let sureActivityIndicator = activityIndicator as? UIActivityIndicatorView else { return }
//
//			sureActivityIndicator.stopAnimating()
//			sureActivityIndicator.removeFromSuperview()
//		}
	}
	
	func showOneButtonAlertModal(title: String?,
								 message: String?,
								 buttonTitle: String = "Ok",
								 onButtonTapped: (()->Void)? = nil) {
		let alertModal = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let action = UIAlertAction(title: buttonTitle, style: .default) { (action) in
			onButtonTapped?()
		}
		alertModal.addAction(action)
		self.present(alertModal, animated: true, completion: nil)
	}
	func showTwoButtonAlertModal(title: String?,
								 message: String?,
								 okButtonTitle: String = "Ok",
								 cancelButtonTitle: String = "Cancel",
								 onOkButtonTapped: (()->Void)?) {
		let alertModal = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let goToSettingsAction = UIAlertAction(title: okButtonTitle, style: .default) { (action) in
			onOkButtonTapped?()
		}
		let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
		alertModal.addAction(goToSettingsAction)
		alertModal.addAction(cancelAction)
		self.present(alertModal, animated: true, completion: nil)
	}
}
