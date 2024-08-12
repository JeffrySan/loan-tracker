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
	
	var addPaymentViewTitle: String {
		return payment == nil ? "Add Payment" : "Edit Payment"
	}
	
	private(set) var payment: Payment?
	private(set) var loan: Loan?
	
	func setLoanObject(loan: Loan) {
		self.loan = loan
	}
	
	func setPaymentObject(payment: Payment?) {
		self.payment = payment
	}
	
	func savePayment() {
		payment == nil ? createNewPayment() : updatePayment()
	}
	
	func isInvalidForm() -> Bool {
		amount.isEmpty
	}
	
	func setupEditView() {
		
		guard let payment = payment else {
			return
		}
		
		amount = String(payment.amount)
		date = payment.wrappedDate
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
		
		guard let payment = payment else {
			return
		}
		
		payment.amount = Double(amount) ?? 0.0
		payment.paymentDate = date
		
		PersistenceController.shared.save()
	}
}
