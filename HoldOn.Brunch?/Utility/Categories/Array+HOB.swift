//
//  Array+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 1/16/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}
