//
//  ViewController.swift
//  movieSearch
//
//  Created by naman  jain on 19/02/22.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController, UITableViewDelegate {
    
    var movieDataSource: MovieData?

    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        self.movieListTableView.rowHeight = 100
        movieSearchBar.delegate = self
        
    }
    
    private func updateUI(with model: MovieData){
        self.movieDataSource = model
        movieListTableView.reloadData()
    }
    
    private func fetchData(with query: String){
        ApiCallers.shared.getAutoCompleteSuggestion(query: query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self.updateUI(with: model)
                    break
                case .failure(let err):
                    print(err)
                }
            }
        }
        movieListTableView.reloadData()
    }

}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moviedata = movieDataSource else{return 1}
        return moviedata.d.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
//        let data = movieDataSource.q ?? "movie title"
        
        if let movieData = movieDataSource{
            let data = movieData.d
            let imageurl = data[indexPath.row].i.imageUrl
            let title = data[indexPath.row].l
            cell.setData(imageUrl: URL(string: imageurl)!, title: title, description: "this is a movie description....This is the movie description and in this description we will show the movie details and all about the movie.")
        }else{
            cell.setData(imageUrl: URL(string: "https://media.istockphoto.com/vectors/movie-time-vector-illustration-cinema-poster-concept-on-red-round-vector-id911590226?k=20&m=911590226&s=612x612&w=0&h=HlJtSKF-fLsKFy1QJ-EVnxXkktBKNS-3jUQPXsSasYs=")!, title: "title", description: "description")
        }
        return cell
    }
}


extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchData(with: searchBar.text!)
    }
    
}
