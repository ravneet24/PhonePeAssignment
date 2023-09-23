//
//  MovieListViewController.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    let viewModel = MovieListViewModel(movieListService: MovieListService())
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
    func setupView() {
        self.moviesTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        moviesTableView.estimatedRowHeight = 225.0
        moviesTableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
    }
}

extension MovieListViewController: MovieListDelegate {
    func didReceiveMovies() {
        //handle success here
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
    
    func didReceiveError(errorMessage: String) {
        //handle error here
    }
}

extension MovieListViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        if let movie = viewModel.getCellViewModel( at: indexPath) {
            cell.configureCell(movie: movie)
            return cell
        }
        
       return UITableViewCell()
    }
    
    func getHeightForRowInSection(section: Int) -> CGFloat {
         UITableView.automaticDimension
    }
    
}

