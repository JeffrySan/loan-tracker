//
//  Date+Extension.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 09/08/24.
//

import Foundation

extension Date {
	var intOfTheYear: Int {
		Calendar.current.dateComponents([.year], from: self).year ?? 0
	}
}
