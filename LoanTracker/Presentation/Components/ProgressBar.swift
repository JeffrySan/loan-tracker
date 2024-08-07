//
//  ProgressBar.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

struct ProgressBar: View {
	
	private let progress: Progress
	
	init(progress: Progress) {
		self.progress = progress
	}
	
    var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				ZStack(alignment: .trailing) {
					Rectangle()
						.frame(width: geometry.size.width, height: geometry.size.height)
						.opacity(0.3)
						.foregroundColor(.teal)
					Text(progress.leftAmount, format: .currency(code: "IDR"))
						.font(.caption)
						.foregroundStyle(.red)
						.padding(.horizontal, 5)
				}
				
				ZStack(alignment: .trailing) {
					
					Rectangle()
						.frame(width: min(CGFloat(progress.value * geometry.size.width), geometry.size.width),
							   height: geometry.size.height)
						.foregroundColor(.blue)
					
					Text(progress.paidAmount, format: .currency(code: "IDR"))
						.font(.caption)
						.padding(.horizontal, 5)
				}
			}
			.cornerRadius(45.0)
		}
    }
}

#Preview {
	ProgressBar(progress: Progress(value: 0.3, leftAmount: 300000, paidAmount: 100000))
}
