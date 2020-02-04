//
//  IntroViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/6/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
	
	private let presenter: IntroPresenter
	
	private let titleLabel = UILabel()
	private let imageView = UIImageView()
	private let button = UIButton()
	
	init(presenter: IntroPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
		
		self.presenter.viewProtocol = self
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
}

// MARK: - View Setup
extension IntroViewController {
	private func setUpSelf() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.isHidden = true
	}
	
	private func setUpTitleLabel() {
		titleLabel.font = UIFont.systemFont(ofSize: 100, weight: .bold)
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.textAlignment = .center
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(titleLabel)
	}
	
	private func setUpImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
	}
	
	private func setUpButton() {
		button.setTitle("It's Ironic!", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.setBackgroundColor(Themes.Default.color, forState: .normal)
		button.add({
			self.presenter.onButtonTapped()
		}, for: .touchUpInside)
		
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
	}
	
	// MARK: Constraints
	private func activateConstraintsForTitleLabel() {
		titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//		titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
		titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
	}
	
	private func activateConstraintsForImageView() {
		//		imageView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: paddingY+200).isActive = true
		imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
		imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
		imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
	private func activateConstraintsForButton() {
		button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		button.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
}

// MARK: - UIViewController
extension IntroViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpSelf()
		setUpTitleLabel()
		setUpImageView()
		setUpButton()
		
//		UIApplication.shared.registerForRemoteNotifications()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		activateConstraintsForTitleLabel()
		activateConstraintsForImageView()
		activateConstraintsForButton()
	}
}

// MARK: - IntroViewProtocol
extension IntroViewController: IntroViewProtocol {
	func setTitleText(_ text: String) {
		titleLabel.text = text
	}
	
	func setImageName(_ imageName: String) {
		imageView.image = UIImage(named: imageName)
	}
	
	func pushPersonSelectVC(persons: [Person]) {
		let presenter = PersonSelectPresenter()
		let vc = PersonSelectViewController(presenter: presenter)
		navigationController?.navigationBar.tintColor = Themes.Default.color
		navigationController?.navigationBar.isHidden = false
		navigationController?.setViewControllers([vc], animated: true)
	}
}
