//
//  TaskTableViewCell.swift
//  EventManager
//
//  Created by Carlotta Chen on 1/28/22.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    weak var delegate: TaskTableViewCellDelegate?
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(self)
        }
    }
    
    func updateViews() {
        guard let task = task else { return }
        
        taskNameLabel.text = task.title
        let checked = UIImage(systemName: "clock.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .regular, scale: .default))
        let unchecked = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .regular, scale: .default))
        if task.isDone {
            completionButton.setBackgroundImage(checked, for: .normal)
        } else {
            completionButton.setBackgroundImage(unchecked, for: .normal)
        }
    }
}


