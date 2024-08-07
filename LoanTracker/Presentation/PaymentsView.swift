//
//  PaymentsView.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

struct PaymentsView: View {
	
	@StateObject private var paymentViewModel = PaymentViewModel()
	
	var loan: Loan
	
	@ViewBuilder
	private func addButton() -> some View {
		NavigationLink(value: Destination.addPayment(loan: loan)) {
			Image(systemName: "plus.circle")
				.font(.title3)
		}
	}
	
    var body: some View {
		VStack {
			// progress view
			Text("Payment Progress")
			
			//
			List {
				ForEach(paymentViewModel.allPayments) { payment in
					PaymentCell(amount: payment.amount, date: payment.wrappedDate)
				}
			}
		}
		.navigationTitle(loan.wrappedName)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem {
				addButton()
			}
		}
		.onAppear {
			paymentViewModel.setLoan(loan: loan)
		}
    }
}

//#Preview {
//	NavigationStack {
//		PaymentsView()
//	}
//}
