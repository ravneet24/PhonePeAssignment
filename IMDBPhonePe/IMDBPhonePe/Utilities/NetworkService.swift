//
//  NetworkWrapper.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

/// This class is interface of RestClient class
class NetworkWrapper {

    static let shared = NetworkWrapper()
    private init() {}

    let restClient = RestClient()
    
    func getDataFromMovieListAPI(language: String, page: Int, completionHanlder: @escaping (Result<Any,Error>) -> ()) {
        let apiBuilder = APIBuilder().buildMovieListAPI(language: language, page: page)
        restClient.request(baseURL: apiBuilder.getUrl(), path: apiBuilder.getPath(),method: apiBuilder.getMethod(), paramters: apiBuilder.buildParameters(), headers: apiBuilder.getRequestHeaders(), completionHandler: completionHanlder)
    }
}

class RestClient {
   
    func request(baseURL: String, path: String, method: RequestMethod, paramters: [String: Any]?, headers: [String:String]? = nil, completionHandler: @escaping (Result<Any,Error>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = path
       
        if let _paramters = paramters {
            urlComponents.setQueryItems(with: _paramters)
        }
        
        guard let url = urlComponents.url else { return }
        let urlSessionConfiguration = URLSessionConfiguration.default
      
        let session = URLSession(configuration: urlSessionConfiguration)
        let task = session.dataTask(with: url) { (data, _ , error) in
            
            if error == nil {
                if let _data = data, let json = try? JSONSerialization.jsonObject(with: _data, options: []) {
                    completionHandler(.success(json))
                }
            } else {
                completionHandler(.failure(error!))
            }
        }
        task.resume()
    }
}
