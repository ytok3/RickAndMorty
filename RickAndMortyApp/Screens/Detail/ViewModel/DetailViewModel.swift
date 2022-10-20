//
//  DetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import Foundation

protocol DetailViewModelOutput {
    func selectCharacter(character: CharacterDetail?)
    func getEpisodeDetail(episode: Episode?)
}

protocol DetailViewModelProtocol {
    var output: DetailViewModelOutput? {get set}
    func lastEpisodeUrl(lastEpisode: String?)
}

class DetailViewModel: DetailViewModelProtocol {
    
    // MARK: Properties
    
    private var service: ServiceManagerProtocol?
    var output: DetailViewModelOutput?
    private let id: Int?
    var lastEpisode: String?
    weak var coordinator: Coordinator?

    // MARK: Init
    
    init(service: ServiceManagerProtocol,
         id: Int?,
         coordinator: Coordinator) {
        self.service = service
        self.id = id
        self.coordinator = coordinator
        
        fetchDetail(id: id)
    }
    
    // MARK: Funcs
    
    func fetchDetail(id: Int?) {
        service?.fetch(url: Constants.generateDetail(with: id!)!, completion: { (response: Result<CharacterDetail, Error>) in
            switch response {
            case .success(let characterDetail):
                self.output?.selectCharacter(character: characterDetail)
                self.lastEpisodeUrl(lastEpisode: characterDetail.episode?.last)
            case .failure:
                print("error detail")
            }
        })
    }
    
    func lastEpisodeUrl(lastEpisode: String?) {
        let episodeUrl = URL(string: lastEpisode!)!
        service?.fetch(url: episodeUrl, completion: { (response: Result<Episode, Error>) in
            switch response {
            case .success(let episodeDetail):
                self.output?.getEpisodeDetail(episode: episodeDetail)
            case .failure:
                print("error episode")
            }
        })
    }
}
