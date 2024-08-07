//
//  AddLoanView.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI
import CoreData

struct AddLoanView: View {
	@Environment(\.dismiss) var dismiss
	
	@StateObject var addLoanViewModel = AddLoanViewModel()
	
	@ViewBuilder
	private func cancelButton() -> some View {
		Button {
			dismiss()
		} label: {
			Text("Cancel")
				.font(.subheadline)
				.fontWeight(.semibold)
		}
	}
	
	@ViewBuilder
	private func confirmButton() -> some View {
		Button {
			addLoanViewModel.saveLoan()
			dismiss()
		} label: {
			Text("Done")
		}
		.disabled(addLoanViewModel.isInvalidForm())
	}
	
	var body: some View {
		NavigationStack {
			VStack {
				Form {
					TextField("Name", text: $addLoanViewModel.name)
						.autocapitalization(.sentences)
					
					TextField("Amount", text: $addLoanViewModel.amount)
						.keyboardType(.decimalPad)
					
					DatePicker("Start Date", 
							   selection: $addLoanViewModel.startDate,
							   in: ...Date(),
							   displayedComponents: .date)
					
					DatePicker("End Date",
							   selection: $addLoanViewModel.dueDate,
							   in: addLoanViewModel.startDate...,
							   displayedComponents: .date)
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					cancelButton()
				}
				
				ToolbarItem(placement: .confirmationAction) {
					confirmButton()
				}
			}
		}
	}
}

#Preview {
	AddLoanView()
}
