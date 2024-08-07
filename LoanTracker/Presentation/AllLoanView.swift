//
//  ContentView.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI
import CoreData

struct AllLoanView: View {
	@Environment(\.managedObjectContext) var viewContext
	
	@State private var isAddLoanShowing = false
	
	@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
				  animation: .default)
	private var loans: FetchedResults<Loan>
	
	@ViewBuilder
	private func addButton() -> some View {
		Button(action: {
			isAddLoanShowing = true
		}, label: {
			Image(systemName: "plus.circle")
				.font(.title3)
		})
		.padding([.vertical, .leading], 5)
	}
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(loans) { loan in
					LoanCell(name: loan.wrappedName,
							 amount: loan.amount,
							 date: loan.wrappedDate)
				}
			}
			.navigationTitle("All Loans")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					addButton()
				}
			}
			.sheet(isPresented: $isAddLoanShowing, content: {
				AddLoanView()
			})
		}
	}
}

#Preview {
	AllLoanView()
}
