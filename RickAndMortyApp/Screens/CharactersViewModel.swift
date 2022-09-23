//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import Foundation

protocol CharactersViewModelOutput {
    func updateData(characters: [Character])
}

protocol CharactersViewModelProtocol {
    var output: CharactersViewModelOutput? {get set}
    func fetchCharacters()
    func fetchSearch(searchText: String?)
}

class  CharactersViewModel: CharactersViewModelProtocol {
    
    // MARK: Properties

    private var service: ServiceManagerProtocol?
    var output: CharactersViewModelOutput?
    
    
    // MARK: Init
    
    init(service: ServiceManagerProtocol) {
        self.service = service
    
        fetchCharacters()
    }
    
    // MARK: Func
    
    func fetchCharacters() {
        service?.fetch(url: Constants.generateURL()!, completion: { (response: Result<CharacterList, Error>) in
            switch response {
            case .success(let charactersList):
                self.output?.updateData(characters: charactersList.results ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchSearch(searchText: String?) {
        service?.fetch(url: Constants.generateSearch(with: .name, searchText: searchText!)!, completion: { (response: Result<CharacterList, Error>) in
            switch response {
            case .success(let searchList):
                self.output?.updateData(characters: searchList.results ?? [])
            case .failure:
                self.service?.fetch(url: Constants.generateSearch(with: .status, searchText: searchText!)!, completion: { (response: Result<CharacterList, Error>) in
                    switch response {
                    case .success(let searchList):
                        self.output?.updateData(characters: searchList.results ?? [])
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        })
    }
}
