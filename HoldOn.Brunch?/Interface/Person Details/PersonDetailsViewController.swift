//
//  PersonDetailsViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 11/14/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController {
	private let presenter: PersonDetailsPresenter
	
	private var personDetails = PersonDetailsViewModel(name: "", image: nil, moodStatus: .new)
	private var detailsView: PersonDetailsView?
	
	init(presenter: PersonDetailsPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
		
		self.presenter.viewProtocol = self
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
}

// MARK: - View Setup
extension PersonDetailsViewController {
	private func setUpSelf() {
		view.backgroundColor = .white
		
		self.detailsView = PersonDetailsView(personDetails: personDetails)
		
		let newView = detailsView.toUIView()
		view.addSubview(newView)
		
		newView.translatesAutoresizingMaskIntoConstraints = false
		newView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		newView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		newView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		newView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
	}
}

// MARK: - UIViewController
extension PersonDetailsViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpSelf()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		presenter.onViewWillDisappear(newDetails: personDetails)
	}
}

// MARK: - PersonDetailsViewProtocol
extension PersonDetailsViewController: PersonDetailsViewProtocol {
	private func getImageForData(_ data: Data?) -> UIImage {
		let image: UIImage
		if let sureImageData = data, let sureImage = UIImage(data: sureImageData) {
			image = sureImage
		} else {
			image = UIImage() // TODO: Add placeholder
		}
		return image
	}
	
	func setPerson(_ person: Person) {
		presenter.retrieveImageDataForPerson(person)
		
		personDetails.name = person.name
		personDetails.moodStatus = person.moodStatus
		personDetails.messageCellVMs = presenter.onGetMessageCellVMs()
		personDetails.onPostMessage = {
			self.presenter.onPostMessageButtonTapped(messageText: self.personDetails.enteredMessageText)
		}
	}
	
	func updatePersonImageData(_ data: Data) {
		let image = getImageForData(data)
		personDetails.image = image
	}
	
	func setPostButtonEnabled(_ enabled: Bool) {
		personDetails.isPostButtonEnabled = enabled
	}
	
	func updateMessagesTable() {
		personDetails.messageCellVMs = presenter.onGetMessageCellVMs()
	}
}
