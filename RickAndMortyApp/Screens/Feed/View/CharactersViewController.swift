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
import DropDown

final class CharactersViewController: UIViewController {
    
    // MARK: View
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
    
    private let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [Constants.DropDown.Alive,
                           Constants.DropDown.Dead]
        return menu
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
        
        noResults.isHidden = true
        
        navController()
        setUpDelegate()
        setUpView()
    }
    
    // MARK: Funcs
    
    func dataIsCatch() {
        indicator.stopAnimating()
        collectionView.isHidden = false
    }
    
    func navController() {

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            title: Constants.Strings.Clear_Filter,
            style: .plain,
            target: self,
            action: #selector(clearFilter)
        )
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
        let filter = UIBarButtonItem(title: Constants.DropDown.Filter, style: .plain, target: self, action: #selector(statusSelected))
        navigationItem.rightBarButtonItem = filter
        
        menu.anchorView = filter
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
        view.addSubview(indicator)
        view.addSubview(noResults)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
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
        navigationItem.leftBarButtonItem?.isEnabled = false
        dataIsCatch()
    }
    
    @objc func statusSelected() {
        menu.show()
        
        menu.selectionAction = { index, title in
            let filter = title
            self.viewModel?.fetchFilter(filter: filter)
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.dataIsCatch()
        }
    }
}

// MARK: - UISearchBarDelegate

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        indicator.startAnimating()
        collectionView.isHidden = true
        noResults.isHidden = true
    }

     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         
         searchBar.endEditing(true)
         
         navigationItem.leftBarButtonItem?.isEnabled = true
         
         viewModel?.fetchSearch(search: searchBar.text)

         searchBar.text = nil
    }
}
// MARK: - CharactersViewModelOutput

extension CharactersViewController: CharactersViewModelOutput {
    
    func noResult() {
        indicator.stopAnimating()
        collectionView.isHidden = true
        noResults.isHidden = false
        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    func updateData(characters: [Character]) {
        delegateAndDataSource?.updateCollectionView(characters: characters)
        dataIsCatch()
        collectionView.reloadData()
        collectionView.setContentOffset(CGPoint.zero, animated: true)
    }
}

// MARK: - CollectionViewDelegateAndDataSourceOutput

extension CharactersViewController: CollectionViewDelegateAndDataSourceOutput {
    
    func didSelectItem(id: Int?) {
        viewModel?.goToCharacterDetail(id: id ?? 0)
    }
}
