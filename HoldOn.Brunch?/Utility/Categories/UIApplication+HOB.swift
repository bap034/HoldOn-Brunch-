//
//  UIApplication+HOB.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 1/8/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
