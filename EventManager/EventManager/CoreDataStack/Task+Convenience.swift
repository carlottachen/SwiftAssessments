//
//  Task+Convenience.swift
//  EventManager
//
//  Created by Carlotta Chen on 1/28/22.
//

import CoreData

extension Task {
    @discardableResult convenience init(title: String, date: Date, isDone: Bool = false, context: NSManagedObjectContext =  CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.date = date
        self.isDone = isDone
    }
}
