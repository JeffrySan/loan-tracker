//
//  PaymentCell.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

struct PaymentCell: View {
	
	let amount: Double
	let date: Date
	
    var body: some View {
		VStack (alignment: .leading, spacing: 5) {
			Text(amount, format: .currency(code: "IDR"))
				.font(.headline)
				.fontWeight(.semibold)
			
			Text(date.formatted(date: .abbreviated, time: .omitted))
				.font(.subheadline)
				.foregroundStyle(.secondary)
		}
    }
}

#Preview {
    PaymentCell(amount: 10000, date: Date())
}
