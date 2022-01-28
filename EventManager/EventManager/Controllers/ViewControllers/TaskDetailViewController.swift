//
//  TaskDetailViewController.swift
//  EventManager
//
//  Created by Carlotta Chen on 1/28/22.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var taskNameLabel: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = taskNameLabel.text, !title.isEmpty else { return }
        let dateStamp = taskDatePicker.date
        
        if let task = task {
            TaskController.shared.updateTask(task: task, newTitle: title, newDate: dateStamp)
        } else {
            let newTask = Task(title: title, date: dateStamp)
            TaskController.shared.createTask(task: newTask)
        }
        navigationController?.popViewController(animated: true)
    }
  
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.title
        taskDatePicker.date = task.date ?? Date()
    }
}
