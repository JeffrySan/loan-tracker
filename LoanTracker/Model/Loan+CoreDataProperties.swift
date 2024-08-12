//
//  Loan+CoreDataProperties.swift
//  LoanTracker
//
//  Created by Jeffry Sandy Purnomo on 07/08/24.
//
//

import Foundation
import CoreData


extension Loan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Loan> {
        return NSFetchRequest<Loan>(entityName: "Loan")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var amount: Double
    @NSManaged public var startDate: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var payments: NSSet?

	public var wrappedName: String {
		return name ?? "Unknown"
	}
	
	public var wrappedDueDate: Date {
		return dueDate ?? Date()
	}
	
	public var wrappedStartDate: Date {
		return startDate ?? Date()
	}
	
	public var paymentArray: [Payment] {
		let set = (payments as? Set<Payment>) ?? []
		
		return set.sorted {
			$0.wrappedDate < $1.wrappedDate
		}
	}
}

extension Loan : Identifiable {

	@objc(addPaymentsObject:)
	@NSManaged public func addToPayments(_ value: Payment)
	
	@objc(removePaymentsObject:)
	@NSManaged public func removeFromPayments(_ value: Payment)
	
	@objc(addPayments:)
	@NSManaged public func addToPayments(_ values: NSSet)
	
	@objc(removePayments:)
	@NSManaged public func removeFromPayments(_ values: NSSet)
}
