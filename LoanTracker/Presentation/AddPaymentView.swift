//
//  AddPaymentView.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

struct AddPaymentView: View {
	@Environment(\.dismiss) var dismiss
	@StateObject var addPaymentViewModel = AddPaymentViewModel()
	
	var loan: Loan
	var payment: Payment?
	
	@ViewBuilder
	private func confirmButton() -> some View {
		Button {
			addPaymentViewModel.savePayment()
			dismiss()
		} label: {
			Text("Done")
		}
		.disabled(addPaymentViewModel.isInvalidForm())
	}
	
    var body: some View {
		Form {
			TextField("Amount", text: $addPaymentViewModel.amount)
				.keyboardType(.numberPad)
			
			DatePicker("Date", 
					   selection: $addPaymentViewModel.date,
					   in: Date()..., 
					   displayedComponents: .date)
		}
		.navigationTitle(addPaymentViewModel.addPaymentViewTitle)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem {
				confirmButton()
			}
		}
		.onAppear {
			addPaymentViewModel.setLoanObject(loan: loan)
			addPaymentViewModel.setPaymentObject(payment: payment)
			addPaymentViewModel.setupEditView()
		}
    }
}

//#Preview {
//	NavigationStack {
//		AddPaymentView()
//	}
//}
