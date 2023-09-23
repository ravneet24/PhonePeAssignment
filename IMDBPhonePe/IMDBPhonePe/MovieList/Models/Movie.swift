//
//  Movie.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation

struct MovieBase: Decodable {
    var results: [Movie]?
}

struct Movie: Decodable {
    var name: String?
    var rating: Double?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case rating = "vote_average"
        case imageURL = "poster_path"
    }
}
