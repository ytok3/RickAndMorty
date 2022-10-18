//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel?
    
    // MARK: Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow

    }

}
