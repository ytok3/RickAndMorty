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
}
