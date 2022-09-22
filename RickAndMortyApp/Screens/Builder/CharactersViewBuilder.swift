//
//  CharactersViewBuilder.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import Foundation
import UIKit
import Alamofire

enum CharactersViewBuilder {
    
    static func build() ->  UIViewController {
        let service = ServiceManager(afSession: Alamofire.Session.default)
        let viewModel = CharactersViewModel(service: service)
        let delegateAndDataSource = CollectionviewDelegateAndDataSource()
        let vc = CharactersViewController(viewModel: viewModel, delegateAndDataSource: delegateAndDataSource)
        
        return vc
    }
}
