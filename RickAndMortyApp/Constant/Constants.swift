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
    static let STATUS = "/?status="
    static let CHARACTERS = "/character"
    static let EPISODE = "/episode"
}

extension Constants {
    static func generateURL() -> URL? {
        URL(string: BASE_URL + CHARACTERS)
    }
    
    static func generateSearch(with search: String) -> URL? {
        URL(string: BASE_URL + CHARACTERS + NAME + search)
    }
    
    static func generateFilter(with filter: String) -> URL? {
        URL(string: BASE_URL + CHARACTERS + STATUS + filter)
    }
  
    static func generateDetail(with characterId:  Int) -> URL? {
        URL(string: BASE_URL + CHARACTERS + "/\(characterId)")
    }
}
