//
//  MovieListService.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation

protocol MovieListServiceProtocol {
    func fetchMoviesFromServer(completionBlock: @escaping (Result<Any,Error>) -> ())
}

class MovieListService: MovieListServiceProtocol  {
    
    func fetchMoviesFromServer(completionBlock: @escaping (Result<Any,Error>) -> ()) {
        NetworkWrapper.shared.getDataFromMovieListAPI(language: "en-US", page: 1) { (result) in
            completionBlock(result)
        }
    }
}
