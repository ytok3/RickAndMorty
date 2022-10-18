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
    static func build(characterId: Int?) -> UIViewController {
        let service = ServiceManager(afSession: Alamofire.Session.default)
        let detailViewModel = DetailViewModel(service: service, id: characterId)
        let vc = DetailViewController(viewModel: detailViewModel)
        
        return vc
    }
}


