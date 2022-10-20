//
//  CollectionViewDelegate+DataSource.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import UIKit

protocol CollectionViewDelegateAndDataSourceOutput: AnyObject {
    func didSelectItem(id: Int?)
}

class CollectionViewDelegateAndDataSource: NSObject {
    
    // MARK: Properties
    
    var characters: [Character] = []
    weak var delegate: CollectionViewDelegateAndDataSourceOutput?
    
    // MARK: Func
    
    func updateCollectionView(characters: [Character]) {
        self.characters = characters
    }
}

// MARK: Extension

extension CollectionViewDelegateAndDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Strings.Cell,
            for: indexPath) as? CollectionViewCell else
        {
            return UICollectionViewCell() }
        cell.configureCharacters(character: characters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(id: characters[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = (UIScreen.main.bounds.size.height) / 4
        return CGSize(width: width, height: height)
    }
}
