//
//  MovieListAPI.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation

struct MovieListAPI {

    private let baseURL = URLList.baseURL
    
    let languageKey: String = "language"
    let pageKey: String = "page"
    
    var page: Int
    var language: String
    
    init(language: String, page: Int) {
        self.language = language
        self.page = page
    }
    
    func getUrl() -> String {
        return "\(baseURL)"
    }
    
    func getPath() -> String {
        return "\(URLList.getMovieList)"
    }
    
    func getMethod() -> RequestMethod {
        return .get
    }
    
    func buildParameters() -> [String:Any]? {
        
        var params: [String: Any] = [:]
        
        params.updateValue(self.language, forKey: languageKey)
        params.updateValue(self.page, forKey: pageKey)
        
        return params
    }
    
    func getRequestHeaders() -> [String: String] {
        var headers: [String: String] = [String: String]()
        headers["accept"] = "application/json"
        headers["Authorization"] = "Bearer 38a73d59546aa378980a88b645f487fc"
        return headers
    }
    
}
