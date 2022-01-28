//
//  TaskListViewController.swift
//  EventManager
//
//  Created by Carlotta Chen on 1/28/22.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewLabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewLabel.delegate = self
        tableViewLabel.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewLabel.reloadData()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.taskCell, for: indexPath) as?
                TaskTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.tasks[indexPath.row]
       
        cell.delegate = self
        cell.task = task
        
        return cell
    }
    
    // support edit table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.deleteTask(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.detailSegue {
           guard let indexPath = tableViewLabel.indexPathForSelectedRow,
                 let destination = segue.destination as? TaskDetailViewController else { return }
        
            let task = TaskController.shared.tasks[indexPath.row]
            destination.task = task
        }
    }

}

extension TaskListViewController: TaskTableViewCellDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        TaskController.shared.toggleIsDone(task: task)
        sender.updateViews()
    }
}
