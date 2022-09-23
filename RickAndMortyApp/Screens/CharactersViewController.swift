//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import UIKit
import Alamofire
import AlamofireImage
import SnapKit

final class CharactersViewController: UIViewController {
    
    // MARK: View
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.Strings.SEARCH
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.Strings.CELL)
        return collectionView
    }()
    
    private let noResult: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = Constants.Strings.NO_RESULTS
        return label
    }()
    
    // MARK: Properties
    
    private var viewModel: CharactersViewModelProtocol?
    private var delegateAndDataSource: CollectionviewDelegateAndDataSource?

    // MARK: Init
    
    init(viewModel: CharactersViewModelProtocol,
         delegateAndDataSource: CollectionviewDelegateAndDataSource) {
        self.viewModel = viewModel
        self.delegateAndDataSource = delegateAndDataSource
        
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.output  = self
        viewModel?.fetchCharacters()
        
        setUpDelegate()
        setUpView()
        
    }
    
    // MARK: Funcs
    
    func setUpDelegate() {
        
        collectionView.delegate = delegateAndDataSource
        collectionView.dataSource = delegateAndDataSource
        searchBar.delegate = self
    }

    func setUpView() {
        
        noResult.isHidden = true
        
        view.backgroundColor = .white
        view.addSubview(noResult)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        noResult.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.bottom.equalTo(view.snp.bottom).offset(-5)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}

// MARK: Extensions

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
        viewModel?.fetchSearch(searchText: searchBar.text!)
        
        searchBar.text = nil
    }
}

extension CharactersViewController: CharactersViewModelOutput {
    func updateData(characters: [Character]) {
        delegateAndDataSource?.updateCollectionView(characters: characters)
        collectionView.reloadData()
    }
}
