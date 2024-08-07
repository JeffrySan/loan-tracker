//
//  Payment+CoreDataProperties.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: Double
    @NSManaged public var id: String?
    @NSManaged public var paymentDate: Date?
    @NSManaged public var loan: Loan?

	public var wrappedDate: Date {
		return paymentDate ?? Date()
	}
}

extension Payment : Identifiable {

}
