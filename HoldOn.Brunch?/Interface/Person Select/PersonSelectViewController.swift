//
//  PersonSelectViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class PersonSelectViewController: UIViewController {
	
	private let presenter: PersonSelectPresenter
	
	private let tableView = UITableView()
	
	init(presenter: PersonSelectPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
		
		self.presenter.viewProtocol = self
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
}

// MARK: - UIViewController
extension PersonSelectViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpSelf()
		setUpTableView()
		
		activateConstraintsForTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		presenter.onViewWillAppear()
	}
}

// MARK: - View Setup
extension PersonSelectViewController {
	private func setUpSelf() {
		view.backgroundColor = .white
		title = "Hold on. Brunch?"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: presenter, action: #selector(presenter.onRightNavigationItemTapped))
	}
	private func setUpTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "personCell")
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
	}
	
	private func activateConstraintsForTableView() {
		tableView.activateConstraintsToPerimeter(ofParentView: view)
	}
}

// MARK: - UITableViewDelegate
extension PersonSelectViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.onDidSelectCellAtIndexPath(indexPath)
	}
}

// MARK: - UITableViewDataSource
extension PersonSelectViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let rows = presenter.onNumberOfCells()
		return rows
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .value1, reuseIdentifier: "personCell")
		cell.selectionStyle = .none
		cell.accessoryType = .disclosureIndicator
		
		if let person = presenter.onCellForIndexPath(indexPath) {
			cell.textLabel?.text = person.name
			
			if person.imageURL != nil {
				if let sureImageData = presenter.getImageDataForPerson(person) {
					let image = UIImage(data: sureImageData)
					cell.imageView?.image = image
				}
			}
			cell.detailTextLabel?.text = person.moodStatus.rawValue
		}
		
		return cell
	}
}

// MARK: - PersonSelectViewProtocol
extension PersonSelectViewController: PersonSelectViewProtocol {
	func presentAddPersonVC(database: HOBModelDatabaseProtocol) {
		let presenter = AddPersonPresenter(database: database)
		let vc = AddPersonViewController(presenter: presenter)
		let nc = UINavigationController(rootViewController: vc)
		navigationController?.present(nc, animated: true, completion: nil)
	}
	
	func pushMoodSelectVC(person: Person, database: HOBModelDatabaseProtocol, storage: HOBStorageProtocol) {
		let presenter = MoodSelectPresenter(person: person, database: database, storage: storage)
		let vc = PersonDetailViewController(presenter: presenter)
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func reloadTableView() {
		tableView.reloadSections([0], with: .automatic) // TODO: animate reload without hardcoded section
	}
}
