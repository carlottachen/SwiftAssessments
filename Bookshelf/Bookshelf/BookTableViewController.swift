//
//  BookTableViewController.swift
//  Bookshelf
//
//  Created by Carlotta Chen on 1/14/22.
//
// This is a Coco Touch Class

import UIKit

class BookTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BookController.books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        // Configure the cell...
        
        let book = BookController.books[indexPath.row]
        cell.textLabel?.text = "\(book.bookTitle) by \(book.authorName)"

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let tappedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let book = BookController.books[tappedIndexPath.row]
        if let detailVC = segue.destination as? BookDetailViewController {
            detailVC.book = book
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.systemTeal
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

}
