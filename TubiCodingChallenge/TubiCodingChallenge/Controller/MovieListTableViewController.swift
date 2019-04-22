//
//  MovieListTableViewController.swift
//  TubiCodingChallenge
//
//  Created by Mitali Kulkarni on 4/19/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call API to get the Movie list
        _ = APIClient.getMovieList(completion: { (movies, error) in
            MovieModel.movieList = movies
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieModel.movieList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let movie = MovieModel.movieList[indexPath.row]
        
        cell.textLabel?.text = movie.title
        let imagePath = movie.imagePath
        // Call to get image for each movie
        APIClient.downloadPosterImage(imagePath: imagePath) { (data, error) in
            guard let imageData = data else {
                return
            }
            let image = UIImage(data: imageData)
            cell.imageView?.image = image
            cell.setNeedsLayout()
        }
        return cell
    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showMovieDetails", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails" {
            let detailVC = segue.destination as! MovieDetailsViewController
            detailVC.movieIndex = MovieModel.movieList[selectedIndex].id
        }
    }
}
