//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import Foundation

protocol CharactersViewModelOutput {
    func updateData(characters: [Character])
    func noResult()
}

protocol CharactersViewModelProtocol {
    var output: CharactersViewModelOutput? {get set}
    var reloadCharacters: [Character] {get set}
    func fetchCharacters()
    func fetchFilter(filter: String?)
    func goToCharacterDetail(id: Int)
}

class  CharactersViewModel: CharactersViewModelProtocol {
    
    // MARK: Properties
    
    private var service: ServiceManagerProtocol?
    var output: CharactersViewModelOutput?
    var reloadCharacters: [Character] = []
    var coordinator: AppCoordinator?
    
    // MARK: Init
    
    init(service: ServiceManagerProtocol,
         coordinator: AppCoordinator
    ) {
        self.service = service
        self.coordinator = coordinator
    
        fetchCharacters()
    }
    
    // MARK: Func
    
    func fetchCharacters() {
        service?.fetch(url: Constants.generateURL()!, completion: { (response: Result<CharacterList, Error>) in
            switch response {
            case .success(let charactersList):
                self.reloadCharacters = charactersList.results ?? []
                self.output?.updateData(characters: charactersList.results ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchFilter(filter: String?) {
        service?.fetch(url: Constants.generateFilter(with: filter!)!, completion: { (response: Result<CharacterList, Error>) in
            switch response {
            case .success(let charactersList):
                self.output?.updateData(characters: charactersList.results ?? [])
            case .failure:
                self.output?.noResult()
            }
        })
    }
    
    func goToCharacterDetail(id: Int) {
        coordinator?.goToDetail(id: id)
    }
}
