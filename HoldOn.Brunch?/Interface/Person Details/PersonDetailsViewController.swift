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
	
	private var personDetails = PersonDetails(name: "", image: nil, moodStatus: .new)
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
		
		self.detailsView = PersonDetailsView(onPostMessage: { message in
			self.presenter.onPostMessageButtonTapped(messageText: message)
		})
		
		let newView = detailsView.environmentObject(personDetails).toUIView()
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
		let imageData = presenter.getImageDataForPerson(person)
		let image = getImageForData(imageData)
		
		personDetails.name = person.name
		personDetails.image = image
		personDetails.moodStatus = person.moodStatus
		personDetails.messages = presenter.onGetMessages()
	}
	
	func updatePersonImageData(_ data: Data) {
		let image = getImageForData(data)
		personDetails.image = image
	}
	
	func setPostButtonEnabled(_ enabled: Bool) {
		view.isUserInteractionEnabled = enabled
	}
	
	func updateMessagesTable() {
		personDetails.messages = presenter.onGetMessages()
	}
}
