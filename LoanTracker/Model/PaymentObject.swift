//
//  PaymentObject.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 09/08/24.
//

import Foundation

struct PaymentObject: Equatable {
	
	let sectionName: String
	let sectionObjects: [Payment]
	let sectionTotal: Double
}
