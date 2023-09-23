//
//  MovieListViewModel.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation

protocol MovieListDelegate: AnyObject {
    func didReceiveMovies()
    func didReceiveError(errorMessage: String)
}

class MovieListViewModel {
    private var movies: [Movie]?
    weak var delegate: MovieListDelegate?
    private let movieListService: MovieListServiceProtocol
    init(movieListService: MovieListServiceProtocol) {
        self.movieListService = movieListService
    }
    
    // MARK:- fetch data
    func fetchMovies() {
        movieListService.fetchMoviesFromServer { [weak self] result in
            switch result {
            case .success(let response):
                print("response ---> \(response)")
                print("API key invalid error is coming.so For now using using static data only")
                self?.fetchStaticMovies()
            case .failure(let error):
                print("error ----> \(error)")
                self?.delegate?.didReceiveError(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func fetchStaticMovies() {
        do {
           if let bundlePath = Bundle.main.path(forResource: "MoviesResponse", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               
               if let movieBase: MovieBase = try? JSONDecoder().decode(MovieBase.self, from: jsonData), let movies = movieBase.results {
                   self.movies = movies
                  self.delegate?.didReceiveMovies()
               }
           }
        } catch {
           print(error)
        }
    }
    
    // MARK:- Table View Helper
    func getNumberOfRows() -> Int {
        movies?.count ?? 0
    }
    
    func getCellViewModel( at indexPath: IndexPath) -> Movie? {
         movies?[indexPath.row]
    }
    
    
}
