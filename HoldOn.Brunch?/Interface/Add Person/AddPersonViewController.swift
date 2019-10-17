//
//  AddPersonViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/6/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

// MARK: - AddPersonViewController
class AddPersonViewController: UIViewController {
	
	private let presenter: AddPersonPresenter
	
	private let containerView = UIView()
	private let nameLabel = UILabel()
	private let nameTextField = UITextField()
	
	init(presenter: AddPersonPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
		
		self.presenter.viewProtocol = self
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
}

// MARK: - UIViewController
extension AddPersonViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpSelf()
		setUpContainerView()
		setUpNameLabel()
		setUpNameTextField()
		
		activateConstraintsForContainerView()
		activateConstraintsForNameLabel()
		activateConstraintsForNameTextField()
	}
}

// MARK: - View Setup
extension AddPersonViewController {
	private func setUpSelf() {
		view.backgroundColor = .white
	}
	private func setUpContainerView() {
		containerView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(containerView)
	}
	private func setUpNameLabel() {
		nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
		nameLabel.text = "Name"
		
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(nameLabel)
	}
	private func setUpNameTextField() {
		nameTextField.borderStyle = .roundedRect
		nameTextField.delegate = self
		
		nameTextField.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(nameTextField)
	}
	
	// MARK: Constraints
	private func activateConstraintsForContainerView() {
		containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
		containerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		containerView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor).isActive = true
	}
	private func activateConstraintsForNameLabel() {
		nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		nameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
	}
	private func activateConstraintsForNameTextField() {
		nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
		nameTextField.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
		nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
		nameTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
	}
}

// MARK: - Events
extension AddPersonViewController {
	@objc func onLeftNavigationItemTapped() {
		presenter.onCancelTapped()
	}
	@objc func onRightNavigationItemTapped() {
		presenter.onSaveTapped(name: nameTextField.text)
	}
}

// MARK: - UITextFieldDelegate
extension AddPersonViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
	}
}

// MARK: - AddPersonViewProtocol
extension AddPersonViewController: AddPersonViewProtocol {
	func setTitle(_ title: String) {
		self.title = title
	}
	
	func setUpLeftNavigationItem() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onLeftNavigationItemTapped))
	}
	
	func setUpRightNavigationItem() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onRightNavigationItemTapped))
	}
	
	func enableRightNavigationItem(_ enable: Bool) {
		navigationItem.rightBarButtonItem?.isEnabled = enable
	}
	
	func dismiss() {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}
