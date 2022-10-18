//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel: DetailViewModel?
    
    // MARK: Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
