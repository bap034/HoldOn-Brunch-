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
	func reloadCell(indexPath: IndexPath)
	func requestAppToShowNotifications()
}

class PersonSelectPresenter {
	
	var viewProtocol: PersonSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var persons = [Person]()
	
	/// Key is the `IndexPath.row`
	private var personsImageData = [String: Data]()
	private let database: HOBModelDatabaseProtocol
	internal let storage: HOBStorageProtocol
	
	init(database: HOBModelDatabaseProtocol = HOBModelDatabase.shared,
		 storage: HOBStorageProtocol = HOBStorage.shared) {
		self.database = database
		self.storage = storage
	}
	
	private func didSetViewProtocol() {}
	
	private func retrieveAsyncPersonsImageData(persons: [Person]) {
		DispatchQueue.global(qos: .userInteractive).async {
			for person in persons {
				guard person.imageURL != nil else { continue }
				
				self.retrieveImageDataForPerson(person)
			}
		}
	}
	
	private func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
		return indexPath.row < persons.count
	}
	
	private func getPersonForIndexPath(_ indexPath: IndexPath) -> Person? {
		guard isValidIndexPath(indexPath) else { return nil }
		
		let person = persons[indexPath.row]
		return person
	}
	private func getIndexPathForPerson(_ person: Person) -> IndexPath? {
		guard let sureIndexPathRow = persons.firstIndex(where: { $0.id == person.id }) else { return nil }
		
		let indexPath = IndexPath(row: sureIndexPathRow, section: 0)
		return indexPath
	}
}

// MARK: - View Exposed Methods
extension PersonSelectPresenter {
	@objc func onRightNavigationItemTapped() {
		viewProtocol?.presentAddPersonVC(database: database)
	}
	
	func getImageDataForPerson(_ person: Person) -> Data? {
		guard person.imageURL != nil else { return nil }
		
		let imageData = personsImageData[person.id]
		return imageData
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
		viewProtocol?.showActivityIndicator(true)
		PersonManager.getAllPersons(success: { (persons) in
			if !self.persons.containsSameElements(as: persons) {
				let isFirstLoad = self.persons.isEmpty
				let needsToChangeRowCount = self.persons.count != persons.count // Prevents a crash for adding or removing rows for new/deleted persons
				self.persons = persons
				self.retrieveAsyncPersonsImageData(persons: persons)
				
				if isFirstLoad || needsToChangeRowCount {
					DispatchQueue.main.async {
						self.viewProtocol?.reloadTableView()
					}
				}
			}
			self.viewProtocol?.showActivityIndicator(false)
		}) { (error) in
			self.viewProtocol?.showActivityIndicator(false)
		}
		
		viewProtocol?.requestAppToShowNotifications()
	}
}

// MARK: - PersonImageRetrievablePresenterProtocol
extension PersonSelectPresenter: PersonImageRetrievablePresenterProtocol {
	func onImageDataComplete(person: Person, cachedData: Data?) {
		guard let sureCachedData = cachedData else { return }
		
		personsImageData[person.id] = sureCachedData
		
		DispatchQueue.main.async {
			if let sureIndexPath = self.getIndexPathForPerson(person) {
				self.viewProtocol?.reloadCell(indexPath: sureIndexPath)
			} else {
				self.viewProtocol?.reloadTableView()
			}
		}
	}
}
