//
//  TaskController.swift
//  EventManager
//
//  Created by Carlotta Chen on 1/28/22.
//

import CoreData

class TaskController {
    
    static let shared = TaskController()
  
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: Strings.task)
        request.predicate = NSPredicate(value: true)
        return request
    } ()
    
    var tasks: [Task] {
        do {
            return try CoreDataStack.context.fetch(self.fetchRequest)
        } catch {
            print("Error fetching entries: \(error.localizedDescription)")
            return []
        }
    }
    
    // Create
    func createTask(task: Task){
        CoreDataStack.saveContext()
    }
    
    // Update
    func updateTask(task: Task, newTitle: String, newDate: Date) {
        task.title = newTitle
        task.date = newDate
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsDone(task: Task) {
        task.isDone.toggle()
        CoreDataStack.saveContext()
    }
    
    // Delete
    func deleteTask(task: Task) {
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
    
}
