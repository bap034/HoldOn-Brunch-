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
	private let scrollView = UIScrollView()
	private let scrollContainerView = UIView()
	
	private let confusedMoodPageView = MoodSelectPageView()
	private let confusingMoodPageView = MoodSelectPageView()

	
	init(presenter: MoodSelectPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
	
}

// MARK: - View Setup
extension MoodSelectViewController {
	private func setUpTitleLabel() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(titleLabel)
	}
	
	private func setUpScrollView() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
	}
	
	private func setUpScrollContainerView() {
		scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(scrollContainerView)
	}
	
	private func setUpConfusedMoodPageView() {
		confusedMoodPageView.imageView.image = UIImage(named: "cat") // TODO: Set by presenter
		confusedMoodPageView.moodLabel.text = "Confused".uppercased() // TODO: Set by presenter
		
		confusedMoodPageView.translatesAutoresizingMaskIntoConstraints = false
		scrollContainerView.addSubview(confusedMoodPageView)
	}
	
	private func setUpConfusingMoodPageView() {
		confusingMoodPageView.imageView.image = UIImage(named: "cat") // TODO: Set by presenter
		confusingMoodPageView.moodLabel.text = "Confusing".uppercased() // TODO: Set by presenter
		
		confusingMoodPageView.translatesAutoresizingMaskIntoConstraints = false
		scrollContainerView.addSubview(confusingMoodPageView)
	}
	
	// MARK: Constraints
	private func activateConstraintsForScrollView() {
		scrollView.activateConstraintsToPerimeter(ofParentView: view)
	}
	private func activateConstraintsForScrollContainerView() {
		scrollContainerView.activateConstraintsToPerimeter(ofParentView: scrollView)
	}
	private func activateConfusedMoodPageView() {
		confusedMoodPageView.centerYAnchor.constraint(equalTo: scrollContainerView.centerYAnchor).isActive = true
		confusedMoodPageView.heightAnchor.constraint(equalTo: scrollContainerView.heightAnchor).isActive = true
		confusedMoodPageView.leftAnchor.constraint(equalTo: scrollContainerView.leftAnchor).isActive = true
		confusedMoodPageView.widthAnchor.constraint(equalTo: scrollContainerView.widthAnchor).isActive = true
	}
	private func activateConfusingMoodPageView() {
		confusingMoodPageView.centerYAnchor.constraint(equalTo: scrollContainerView.centerYAnchor).isActive = true
		confusingMoodPageView.heightAnchor.constraint(equalTo: scrollContainerView.heightAnchor).isActive = true
		confusingMoodPageView.leftAnchor.constraint(equalTo: confusedMoodPageView.rightAnchor).isActive = true
		confusingMoodPageView.rightAnchor.constraint(equalTo: scrollContainerView.rightAnchor).isActive = true
		confusingMoodPageView.widthAnchor.constraint(equalTo: scrollContainerView.widthAnchor).isActive = true
	}
}

extension MoodSelectViewController: MoodSelectViewProtocol {
	func setTitleText(_ text: String?) {
		titleLabel.text = text
	}
}
