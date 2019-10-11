//
//  PersonSelectPresenter.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

struct PersonSelectCellData {
	
}

protocol PersonSelectViewProtocol {
	func pushMoodSelectVC(person: Person, dataBase: UserDefaults)
	func reloadTableView()
}

class PersonSelectPresenter {
	
	var viewProtocol: PersonSelectViewProtocol? { didSet { didSetViewProtocol() } }
	private var persons = [Person]()
	private let dataBase: UserDefaults
	
	init(dataBase: UserDefaults = UserDefaults.standard) {
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
		let personsKeys = dataBase.getPersonsKeys()
		let newPersons = dataBase.getAllPersonsForKeys(personsKeys)
		persons = newPersons
		
		viewProtocol?.reloadTableView()
	}
}
