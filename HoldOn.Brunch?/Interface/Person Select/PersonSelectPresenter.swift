//
//  PersonSelectPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

protocol PersonSelectViewProtocol: ViewProtocol {
	func pushMoodSelectVC(person: Person, dataBase: HOBModelDatabaseProtocol)
	func reloadTableView()
}

class PersonSelectPresenter {
	
	var viewProtocol: PersonSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var persons = [Person]()
	private let dataBase: HOBModelDatabaseProtocol
	
	init(dataBase: HOBModelDatabaseProtocol = HOBModelDatabase.shared) {
		self.dataBase = dataBase
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
	func onNumberOfCells() -> Int {
		return persons.count
	}
	
	func onCellForIndexPath(_ indexPath: IndexPath) -> Person? {
		let person = getPersonForIndexPath(indexPath)
		return person
	}
	
	func onDidSelectCellAtIndexPath(_ indexPath: IndexPath) {
		guard let person = getPersonForIndexPath(indexPath) else { return }
		
		viewProtocol?.pushMoodSelectVC(person: person, dataBase: dataBase)
	}
	
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
