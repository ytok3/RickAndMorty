//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import Foundation

// MARK: - LastEpisode
struct Episode: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
            case id, name
            case airDate = "air_date"
            case episode, characters, url, created
        }
}
