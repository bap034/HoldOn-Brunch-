//
//  SelectImageView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/17/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class SelectImageView: UIView {
	var onTapped: (()->Void)?
	
	let imageView = UIImageView()
	let plusLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		setUpSelf()
		setUpImageView()
		setUpPlusLabel()
		
		activateConstraintsForImageView()
		activateConstraintsForPlusLabel()
	}
	required init?(coder: NSCoder) { fatalError() }
	
}

// MARK: - View Setup
extension SelectImageView {
	private func setUpSelf() {
		backgroundColor = .white
		layer.borderWidth = 3
		layer.borderColor = Themes.Default.color.cgColor
		layer.cornerRadius = 6
		layer.masksToBounds = true
		isUserInteractionEnabled = true
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onSelectImageTapped))
		addGestureRecognizer(tapGestureRecognizer)
	}
	private func setUpImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.isUserInteractionEnabled = true
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		insertSubview(imageView, aboveSubview: plusLabel)
	}
	private func setUpPlusLabel() {
		plusLabel.text = "+"
		plusLabel.textColor = Themes.Default.color
		plusLabel.textAlignment = .center
		plusLabel.font = UIFont.systemFont(ofSize: 50)
		plusLabel.adjustsFontSizeToFitWidth = true
		plusLabel.isUserInteractionEnabled = true
		
		plusLabel.translatesAutoresizingMaskIntoConstraints = false
		insertSubview(plusLabel, belowSubview: imageView)
	}
	
	// MARK: Constraints
	private func activateConstraintsForImageView() {
		imageView.activateConstraintsToPerimeter(ofParentView: self)
	}
	private func activateConstraintsForPlusLabel() {
		plusLabel.activateConstraintsToPerimeter(ofParentView: self)
	}
}

extension SelectImageView {
	@objc func onSelectImageTapped() {
		onTapped?()
	}
}
