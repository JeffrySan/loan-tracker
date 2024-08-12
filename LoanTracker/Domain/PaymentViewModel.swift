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
		calculateDaysToFinish()
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
			calculateDaysToFinish()
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
	
	func calculateDaysToFinish() {
		
		guard let loan else {
			return
		}
		
		let allPaymentAmount: Double = allPayments.reduce(0) { $0 + $1.amount }
		let days = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: loan.wrappedDueDate).day!
		let passedDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: Date()).day!
		
		if passedDays == 0 || allPaymentAmount == 0 {
			expectedToFinishOn = ""
			return
		}
		
		let didPayPerDay = allPaymentAmount / Double(passedDays)
		let shouldPayPerDay = loan.amount / Double(days)
		
		if shouldPayPerDay > didPayPerDay {
			// we are ahead from the scedule
		} else {
			// we are behind from the scedule
		}
		let daysLeftToFinish = (loan.amount - allPaymentAmount) / didPayPerDay
		
		guard let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish),to: Date()) else {
			expectedToFinishOn = "Should be Finished!"
			return
		}
		expectedToFinishOn = "Expected to Finish by \(newDate.formatted(date: .abbreviated, time: .omitted))"
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
}
