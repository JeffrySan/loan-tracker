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
	@Published private(set) var allPaymentObject: [PaymentObject] = []
	
	private var loan: Loan?
	
	func setLoan(loan: Loan) {
		self.loan = loan
		setPayments()
		calculateProgress()
		separateByYear()
	}
	
	private func calculateProgress() {
		
		guard let loan else {
			return
		}
		
		let allPaymentAmount: Double = allPayments.reduce(0) { $0 + $1.amount }
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
	
	func delete(paymentObject: PaymentObject, index: IndexSet) {
		guard let deleteIndex = index.first else {
			return
		}
		
		let paymentToDelete = paymentObject.sectionObjects[deleteIndex]
		
		PersistenceController.shared.viewContext.delete(paymentToDelete)
		PersistenceController.shared.save()
		
		setPayments()
		
		withAnimation {
			calculateProgress()
		}
		
		separateByYear()
	}
	
	func separateByYear() {
		allPaymentObject.removeAll()
		
		let dictionary = Dictionary(grouping: allPayments, by: { $0.wrappedDate.intOfTheYear })
		
		for (key, value) in dictionary {
			let totalAmountOfTheYear = value.reduce(0, { $0 + $1.amount })
			
			let newPaymentObject = PaymentObject(sectionName: "\(key)",
												 sectionObjects: value.reversed(),
												 sectionTotal: totalAmountOfTheYear)
			allPaymentObject.append(newPaymentObject)
		}
		
		allPaymentObject.sort(by: { $0.sectionName > $1.sectionName })
	}
}
