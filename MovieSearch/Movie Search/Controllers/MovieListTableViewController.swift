//
//  MovieListTableViewController.swift
//  Movie Search
//
//  Created by Carlotta Chen on 2/4/22.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [MovieObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as?
                MovieTableViewCell else { return UITableViewCell() }

        let movie = movies[indexPath.row]
        
        cell.movie = movie

        return cell
    }
    
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        
        MovieController.fetchMovie(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
