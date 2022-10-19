//
//  DetailViewBuilder.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import Foundation
import UIKit
import Alamofire

enum DetailViewBuilder {
    static func build(characterId: Int?, coordinator: AppCoordinator) -> DetailViewController {
        let service = ServiceManager(afSession: Alamofire.Session.default)
        let viewModel = DetailViewModel(service: service, id: characterId, coordinator: coordinator)
        let vc = DetailViewController(viewModel: viewModel)
        
        return vc
    }
}


