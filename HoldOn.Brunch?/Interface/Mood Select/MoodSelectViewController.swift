//
//  MoodSelectViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class MoodSelectViewController: UIViewController {
	
	private let presenter: MoodSelectPresenter
	
	private let titleLabel = UILabel()
	private let imageView = UIImageView()
	private let scrollView = UIScrollView()
	private let scrollContainerView = UIView()
	
	private let confusedMoodPageView = MoodSelectPageView()
	private let confusingMoodPageView = MoodSelectPageView()

	
	init(presenter: MoodSelectPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
		
		self.presenter.viewProtocol = self
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
	
}

// MARK: - View Setup
extension MoodSelectViewController {
	private func setUpSelf() {
		view.backgroundColor = .white
	}
	
	private func setUpTitleLabel() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(titleLabel)
	}
	
	private func setUpImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
	}
	
	private func setUpScrollView() {
		scrollView.isScrollEnabled = true
		scrollView.isPagingEnabled = true
		scrollView.isDirectionalLockEnabled = true
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
	}
	
	private func setUpScrollContainerView() {
		scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(scrollContainerView)
	}
	
	private func setUpConfusedMoodPageView() {
//		confusedMoodPageView.imageView.image =  UIImage(named: "cat") // TODO: Set by presenter
		confusedMoodPageView.moodLabel.text = "Confused".uppercased() // TODO: Set by presenter
		
		confusedMoodPageView.translatesAutoresizingMaskIntoConstraints = false
		scrollContainerView.addSubview(confusedMoodPageView)
	}
	
	private func setUpConfusingMoodPageView() {
//		confusingMoodPageView.imageView.image = UIImage(named: "cat") // TODO: Set by presenter
		confusingMoodPageView.moodLabel.text = "Confusing".uppercased() // TODO: Set by presenter
		
		confusingMoodPageView.translatesAutoresizingMaskIntoConstraints = false
		scrollContainerView.addSubview(confusingMoodPageView)
	}
	
	// MARK: Constraints
	private func activateConstraintsForTitleLabel() {
		let padding = view.safeAreaInsets.top + 20
		titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
	}
	
	private func activateConstraintsForImageView() {
//		imageView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: paddingY+200).isActive = true
		imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
		imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
		imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
	private func activateConstraintsForScrollView() {
		scrollView.activateConstraintsToPerimeter(ofParentView: view)
	}
	private func activateConstraintsForScrollContainerView() {
		scrollContainerView.activateConstraintsToPerimeter(ofParentView: scrollView)
		scrollContainerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
		scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2).isActive = true // TODO: fix to be intrinsic?
	}
	private func activateConstraintsForConfusedMoodPageView() {
		confusedMoodPageView.centerYAnchor.constraint(equalTo: scrollContainerView.centerYAnchor).isActive = true
		confusedMoodPageView.heightAnchor.constraint(equalTo: scrollContainerView.heightAnchor).isActive = true
		confusedMoodPageView.leftAnchor.constraint(equalTo: scrollContainerView.leftAnchor).isActive = true
		confusedMoodPageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
	}
	private func activateConstraintsForConfusingMoodPageView() {
		confusingMoodPageView.centerYAnchor.constraint(equalTo: scrollContainerView.centerYAnchor).isActive = true
		confusingMoodPageView.heightAnchor.constraint(equalTo: scrollContainerView.heightAnchor).isActive = true
		confusingMoodPageView.leftAnchor.constraint(equalTo: confusedMoodPageView.rightAnchor).isActive = true
//		confusingMoodPageView.rightAnchor.constraint(equalTo: scrollContainerView.rightAnchor).isActive = true
		confusingMoodPageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
	}
}

// MARK: - UIViewController
extension MoodSelectViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpSelf()
		setUpTitleLabel()
		setUpImageView()
		setUpScrollView()
		setUpScrollContainerView()
		setUpConfusedMoodPageView()
		setUpConfusingMoodPageView()
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		activateConstraintsForTitleLabel()
		activateConstraintsForImageView()
		activateConstraintsForScrollView()
		activateConstraintsForScrollContainerView()
		activateConstraintsForConfusedMoodPageView()
		activateConstraintsForConfusingMoodPageView()		
	}
}

// MARK: - MoodSelectViewProtocol
extension MoodSelectViewController: MoodSelectViewProtocol {
	func setTitleText(_ text: String?) {
		titleLabel.text = text
	}
	
	func setImageName(_ imageName: String) {
		imageView.image = UIImage(named: imageName)
	}
}
