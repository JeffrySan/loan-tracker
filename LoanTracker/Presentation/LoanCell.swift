//
//  LoanCell.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

struct LoanCell: View {
	
	var name: String
	var amount: Double
	let date: Date
	
    var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 5) {
				Text(name)
					.font(.headline)
					.fontWeight(.semibold)
				
				Text(amount, format: .currency(code: "IDR"))
					.font(.subheadline)
					.fontWeight(.light)
			}
			
			Spacer()
			
			Text(date.formatted(date: .abbreviated, time: .omitted))
				.font(.subheadline)
				.fontWeight(.light)
		}
    }
}

#Preview {
	LoanCell(name: "Loan 1", amount: 15000, date: Date())
}
