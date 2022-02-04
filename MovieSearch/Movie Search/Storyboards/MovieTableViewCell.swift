//
//  MovieTableViewCell.swift
//  Movie Search
//
//  Created by Carlotta Chen on 2/4/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: MovieObj? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.originalTitle
        ratingLabel.text = "Rating: \(movie.voteAverage)"
        descriptionLabel.text = movie.overview
        
        MovieController.fetchImage(movie: movie) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.movieImage.image = image
                case .failure(let error):
                    self.movieImage.image = UIImage(systemName: "sparkles")
                    print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
