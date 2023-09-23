//
//  URLComponents+Extension.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    
}
