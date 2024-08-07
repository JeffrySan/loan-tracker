//
//  LoanTrackerApp.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//

import SwiftUI

@main
struct LoanTrackerApp: App {
	var body: some Scene {
		WindowGroup {
			AllLoanView()
				.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
		}
	}
}
