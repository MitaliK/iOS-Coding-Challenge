#  Tubi TV iOS Engineer Coding Challenge

## Features
* Fetch movies list data, display it in a collection view or table view
* When user taps on a cell, the app should open the movie details view
    * Please use the movie id from the movies list to fetch the movie details
    * Please display index field from movie details in your detail view
* Please implement your own LRU (least recently used) cache for movie details
    * Maximum size should be 5
    * The cache should support add, get, isValid. All operations must be O(1)
        * add: add one item to cache
        * get: get one item based on key from cache
        * isValid: check if a item is still valid based on the key
* Once movie details view is displayed, the app should check LRU cache first
    * If cache exists, use cache to display movie details
    * If cache doesn’t exist, fetch data from movie details endpoint. After getting data from endpoint, display movie details
* Unit tests

## Code Structure
### View
* Main.storyboard

### Controller
* MovieListTableViewController.swift provides the logic to display the movie lists and is the first page of the app
* MovieDetailsViewController.swift provides the logic to display the movie details with Image, index and title

### Model
* APIClient.swift provides logic for making HTTP calls for the API endpoints 
* Movie.swift provides structure for data fetched for Movie
* MovieMode.swift is structure for array of movies
* MovieDetails.swift provides structure for data fetched by MovieDetails end point
* LRUCache.swift provides logic for LRU cache used to store MovieDetails
    * We use Dictionay and Doubly LinkedList
    * Dictionay in order to store the elements and retrive the elements in O(1)
    * Doubly LinkedList in order to remove the element from the linkedlist in O(1)

## Additions
* Info.plist: Added App Transport Security Settings inorder to allow loading of http urls
