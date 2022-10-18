//
//  DetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import Foundation

protocol DetailViewmodelOutput {
    func selectCharacter(character: CharacterDetail?)
    
}

protocol DetailViewModelProtocol {
    
    var output: DetailViewmodelOutput? {get set}
    
}

class DetailViewModel: DetailViewModelProtocol {
    
    private var service: ServiceManagerProtocol?
    var output: DetailViewmodelOutput?
    private let id: Int?
    
    
    init(service: ServiceManagerProtocol,
         id: Int?) {
        self.service = service
        self.id = id
        
        fetchDetail(id: id)
    }
    
    func fetchDetail(id: Int?) {
        service?.fetch(url: Constants.generateDetail(with: id ?? 1)!, completion: { (response: Result<CharacterDetail, Error>) in
            switch response {
            case .success(let characterDetail):
                self.output?.selectCharacter(character: characterDetail)
            case .failure:
                print("error detail")
            }
        })
    }
}
