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
        searchBar.placeholder = Constants.Strings.Search
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.Strings.Cell)
        return collectionView
    }()
    
    private let noResults: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = Constants.Strings.No_Result
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Properties
    
    private var viewModel: CharactersViewModelProtocol?
    private var delegateAndDataSource: CollectionViewDelegateAndDataSource?

    // MARK: Init
    
    init(viewModel: CharactersViewModelProtocol,
         delegateAndDataSource: CollectionViewDelegateAndDataSource) {
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
        
        title = "Rick And Morty"
  
        navController()
        setUpDelegate()
        setUpView()
    }
    
    // MARK: Funcs
    
    func navController() {

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            title: Constants.Strings.Cancel_Filter,
            style: .plain,
            target: self,
            action: #selector(clearFilter)
        )
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    func setUpDelegate() {
        collectionView.delegate = delegateAndDataSource
        collectionView.dataSource = delegateAndDataSource
        delegateAndDataSource?.delegate = self
        searchBar.delegate = self
    }

    func setUpView() {
        noResults.isHidden = true
        view.backgroundColor = .white
        view.addSubview(noResults)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        noResults.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(view.snp.width)
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
    
    @objc func clearFilter() {
    
        updateData(characters: viewModel?.reloadCharacters ?? [])
        navigationItem.rightBarButtonItem?.isEnabled = false
        collectionView.isHidden = false
    }
}

// MARK: Extensions

extension CharactersViewController: UISearchBarDelegate {

     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         
         navigationItem.leftBarButtonItem?.isEnabled = true
         
         searchBar.endEditing(true)
         
         viewModel?.fetchFilter(filter: searchBar.text)

         searchBar.text = nil
     }
 }

extension CharactersViewController: CharactersViewModelOutput {
    func noResult() {
        collectionView.isHidden = true
        noResults.isHidden = false
        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    func updateData(characters: [Character]) {
        delegateAndDataSource?.updateCollectionView(characters: characters)
        collectionView.reloadData()
    }
}

extension CharactersViewController: CollectionViewDelegateAndDataSourceOutput {
    func didSelectItem(id: Int?) {
        viewModel?.goToCharacterDetail(id: id ?? 0)
    }
}
