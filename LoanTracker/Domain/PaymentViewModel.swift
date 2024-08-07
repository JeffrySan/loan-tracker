//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {
	
	@Published private(set) var expectedToFinishOn = ""
	@Published private(set) var progress = ""
	@Published private(set) var allPayments: [Payment] = []
	@Published private(set) var allPaymentObject: [String] = []
	
	private var loan: Loan?
	
	func setLoan(loan: Loan) {
		self.loan = loan
		setPayments()
	}
	
	private func setPayments() {
		guard let loan else {
			return
		}
		
		allPayments = loan.paymentArray
	}
}
