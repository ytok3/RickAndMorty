//
//  CollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import UIKit
import AlamofireImage
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: View
    
    private let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let species: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        
        configureCells()
        configureCellsConstraint()
    }
    
    // MARK: Funcs
    
    func configureCells() {
        
        contentView.addSubview(characterImage)
        contentView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(name)
        verticalStack.addArrangedSubview(status)
        verticalStack.addArrangedSubview(species)
        
        characterImage.layer.cornerRadius = 5
    }
    
    func configureCharacters(character: Character) {

        self.characterImage.af.setImage(withURL: URL(string: (character.image!))!)
        self.name.text = character.name
        self.status.text = character.status
        self.species.text = character.species
    }
    
    func configureCellsConstraint() {
        
        characterImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(3)
            make.left.equalTo(contentView).offset(3)
            make.right.equalTo(contentView).offset(-3)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(140)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(3)
            make.left.equalTo(contentView).offset(3)
            make.right.equalTo(contentView).offset(-3)
            make.bottom.equalTo(contentView).offset(-3)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(verticalStack.snp.top).offset(3)
        }
        
        status.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(3)
        }
        
        species.snp.makeConstraints { make in
            make.top.equalTo(status.snp.bottom).offset(3)
            make.bottom.equalTo(verticalStack.snp.bottom).offset(-3)
        }
    }
}

