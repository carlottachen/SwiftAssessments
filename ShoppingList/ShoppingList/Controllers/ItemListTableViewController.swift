//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by Carlotta Chen on 1/21/22.
//

import UIKit

class ItemListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistenceStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toItemDetails", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.item = item

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? ItemDetailViewController else { return }
            let item = ItemController.shared.items[indexPath.row]
            destination.item = item
        }
    }

}

extension ItemListTableViewController: ItemCompletionDelegate {
    func itemCheckboxTapped(_ sender: ItemTableViewCell) {
        guard let item = sender.item else { return }
        ItemController.shared.togglePurchased(item: item)
        sender.updateViews()
    }
}
