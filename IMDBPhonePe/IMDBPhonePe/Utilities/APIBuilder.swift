//
//  APIBuilder.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation
struct APIBuilder {
     func buildMovieListAPI(language: String, page: Int) -> MovieListAPI {
        let apiObject = MovieListAPI(language: language, page: page)
        return apiObject
    }
}
