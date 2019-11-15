//
//  PersonSelectPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol PersonSelectViewProtocol: ViewProtocol {
	func presentAddPersonVC(database: HOBModelDatabaseProtocol)
	func pushMoodSelectVC(person: Person, database: HOBModelDatabaseProtocol, storage: HOBStorageProtocol)
	func reloadTableView()
}

class PersonSelectPresenter {
	
	var viewProtocol: PersonSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var persons = [Person]()
	private let database: HOBModelDatabaseProtocol
	internal let storage: HOBStorageProtocol
	
	init(database: HOBModelDatabaseProtocol = HOBModelDatabase.shared,
		 storage: HOBStorageProtocol = HOBStorage.shared) {
		self.database = database
		self.storage = storage
	}
	
	private func didSetViewProtocol() {
		
	}
	
	private func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
		return indexPath.row < persons.count
	}
	
	private func getPersonForIndexPath(_ indexPath: IndexPath) -> Person? {
		guard isValidIndexPath(indexPath) else { return nil }
		
		let person = persons[indexPath.row]
		return person
	}
}

// MARK: - View Exposed Methods
extension PersonSelectPresenter {
	@objc func onRightNavigationItemTapped() {
		viewProtocol?.presentAddPersonVC(database: database)
	}
	
	// MARK: TableViewDataSource
	func onNumberOfCells() -> Int {
		return persons.count
	}
	
	func onCellForIndexPath(_ indexPath: IndexPath) -> Person? {
		let person = getPersonForIndexPath(indexPath)
		return person
	}
	
	// MARK: TableViewDelegate
	func onDidSelectCellAtIndexPath(_ indexPath: IndexPath) {
		guard let person = getPersonForIndexPath(indexPath) else { return }
		
		viewProtocol?.pushMoodSelectVC(person: person, database: database, storage: storage)
	}
	
	// MARK: ViewController
	func onViewWillAppear() {
		viewProtocol?.showNetworkActivityIndicator(true)
		PersonManager.getAllPersons(success: { (persons) in
			self.persons = persons
			self.viewProtocol?.reloadTableView()
			self.viewProtocol?.showNetworkActivityIndicator(false)
		}) { (error) in
			self.viewProtocol?.showNetworkActivityIndicator(false)
		}
	}
}

// MARK: - PersonImageRetrievablePresenterProtocol
extension PersonSelectPresenter: PersonImageRetrievablePresenterProtocol {
	func onImageDataComplete(cachedData: Data?) {
		if cachedData != nil {
			self.viewProtocol?.reloadTableView() // TODO: reload only that cell
		}
	}
}
