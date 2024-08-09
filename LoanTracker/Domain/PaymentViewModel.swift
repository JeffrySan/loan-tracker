//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {
	
	@Published private(set) var expectedToFinishOn = ""
	@Published private(set) var progress = Progress()
	@Published private(set) var allPayments: [Payment] = []
	@Published private(set) var allPaymentObject: [String] = []
	
	private var loan: Loan?
	
	func setLoan(loan: Loan) {
		self.loan = loan
		setPayments()
		calculateProgress()
	}
	
	private func calculateProgress() {
		
		guard let loan else {
			return
		}
		
		let allPaymentAmount: Double = allPayments.map { payment -> Double in
			return payment.amount
		}.reduce(0) { $0 + $1 }
		let loanAmount = loan.amount
		
		progress = Progress(value: (allPaymentAmount / loanAmount),
							leftAmount: loanAmount - allPaymentAmount,
							paidAmount: allPaymentAmount)
	}
	
	private func setPayments() {
		guard let loan else {
			return
		}
		
		allPayments = loan.paymentArray
	}
}
