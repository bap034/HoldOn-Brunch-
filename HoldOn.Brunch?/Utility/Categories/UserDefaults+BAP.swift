//
//  UserDefaults+BAP.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/5/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Foundation

private let userStateKey = "kUserState"
private let moodStatusKey = "kMoodStatus"

extension UserDefaults {
	// MARK: - UserState
	static func storeUserState(_ userState: UserState) {
		// MoodStatus
		UserDefaults.standard.set(userState.moodStatus, forKey: moodStatusKey)
	}
	
	static func getUserState() -> UserState {
		// MoodStatus
		let moodStatusString = UserDefaults.standard.string(forKey: moodStatusKey)
		
		let moodStatus: MoodStatus
		if let sureMoodStatusString = moodStatusString {
			let determinedMoodStatus = MoodStatus(rawValue: sureMoodStatusString)
			moodStatus = determinedMoodStatus ?? .new
		} else {
			moodStatus = .new
		}
		
		let userState = UserState(moodStatus: moodStatus)
		return userState
	}
}
