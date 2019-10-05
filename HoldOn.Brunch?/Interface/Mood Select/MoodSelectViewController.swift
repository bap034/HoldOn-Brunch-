//
//  MoodSelectViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import UIKit

class MoodSelectViewController: UIViewController {
	
	private let presenter: MainPresenter
	
	private let titleLabel = UILabel()
	private let scrollView = UIScrollView()
	private let scrollContainerView = UIView()
	
	init(presenter: MainPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
	
	
}
