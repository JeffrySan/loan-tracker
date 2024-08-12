//
//  Destination.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import Foundation

enum Destination: Hashable {
	case payment(loan: Loan)
	case addPayment(loan: Loan, payment: Payment? = nil)
}
