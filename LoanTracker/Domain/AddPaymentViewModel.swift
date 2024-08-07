//
//  AddPaymentViewModel.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import Foundation

final class AddPaymentViewModel: ObservableObject {
	@Published var amount = ""
	@Published var date = Date()
	
	private(set) var loan: Loan?
	
	func setLoanObject(loan: Loan) {
		self.loan = loan
	}
	
	func savePayment() {
		createNewPayment()
	}
	
	private func createNewPayment() {
		let payment = Payment(context: PersistenceController.shared.viewContext)
		payment.id = UUID().uuidString
		payment.amount = Double(amount) ?? 0.0
		payment.loan = loan
		payment.paymentDate = date
		
		PersistenceController.shared.save()
	}
	
	private func updatePayment() {
		
	}
	
	func isInvalidForm() -> Bool {
		amount.isEmpty
	}
}
