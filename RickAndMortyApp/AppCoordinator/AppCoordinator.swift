//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? {get set}
    func goToDetail(id: Int?)
    func start()
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        navigationController?.pushViewController(CharactersViewBuilder.build(appCoordinator: self), animated: false)
    }
    
    func goToDetail(id: Int?) {
        navigationController?.pushViewController(DetailViewBuilder.build(characterId: id), animated: true)
    }
}
