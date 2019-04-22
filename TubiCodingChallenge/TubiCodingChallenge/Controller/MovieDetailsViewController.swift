//
//  MovieDetailsViewController.swift
//  TubiCodingChallenge
//
//  Created by Mitali Kulkarni on 4/21/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieIndexLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movieIndex: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call to get the movie details
        _ = APIClient.getMovieDetails(key: movieIndex, completion: { (movieDetails, error) in
            guard let movieDetail = movieDetails else {
                return
            }
            
            self.navigationItem.title = movieDetail.title
            self.movieIndexLabel.text = "\(movieDetail.index)"
            self.movieTitleLabel.text = movieDetail.title
            
            let imagePath = movieDetail.imagePath
            APIClient.downloadPosterImage(imagePath: imagePath) { (data, error) in
                guard let imageData = data else {
                    return
                }
                let image = UIImage(data: imageData)
                self.movieImageView.image = image
            }
        })
    }
}
