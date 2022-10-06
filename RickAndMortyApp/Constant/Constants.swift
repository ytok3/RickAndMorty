//
//  Constants.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import Foundation

struct Constants {
    
    static let BASE_URL = "https://rickandmortyapi.com/api"
    
    static let NAME = "/?name="
    static let CHARACTERS = "/character"
    static let EPISODE = "/episode"
}

extension Constants {
    static func generateURL() -> URL? {
        URL(string: BASE_URL + CHARACTERS)
    }
    
    static func generateFilter(with filterName: String) -> URL? {
        URL(string: BASE_URL + CHARACTERS + NAME + filterName)
    }
}
