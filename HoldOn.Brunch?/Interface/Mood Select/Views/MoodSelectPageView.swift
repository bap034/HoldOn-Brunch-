//
//  MoodSelectPageView.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class MoodSelectPageView: UIView {
	
	let imageView = UIImageView()
	let moodLabel = UILabel()
	
	private let paddingY:CGFloat = 10
	private let paddingX:CGFloat = 10
}

// MARK: - View Setup
extension MoodSelectPageView {
	private func setUpImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(imageView)
	}
	
	private func setUpMoodLabel() {
		moodLabel.translatesAutoresizingMaskIntoConstraints = false
		moodLabel.numberOfLines = 3
		moodLabel.adjustsFontSizeToFitWidth = true
		addSubview(moodLabel)
	}
	
	private func activateConstraintsForImageView() {
		imageView.topAnchor.constraint(equalTo: topAnchor, constant: paddingY).isActive = true
		imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
		imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 400).isActive = true
		imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
	}
	
	private func activateConstraintsForMoodLabel() {
		moodLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: paddingY*2).isActive = true
		moodLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingX).isActive = true
		moodLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -paddingX).isActive = true
		moodLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingY).isActive = true
	}
}
