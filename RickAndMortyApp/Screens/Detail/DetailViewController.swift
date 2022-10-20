//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 18.10.2022.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: View
    
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .white
        return image
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var species: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var numberOfEpisodes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var gender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var originLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var lastKnownLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var lastSeenEpisode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var lastSeenEpisodeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var lastSeenEpisodeAirDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
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
        
        viewModel?.output = self
        
        setUpView()
        setUpConstraint()
    }
    
    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(characterImage)
        view.addSubview(verticalStack)
        verticalStack.addSubview(name)
        verticalStack.addSubview(status)
        verticalStack.addSubview(species)
        verticalStack.addSubview(numberOfEpisodes)
        verticalStack.addSubview(gender)
        verticalStack.addSubview(originLocation)
        verticalStack.addSubview(lastKnownLocation)
        verticalStack.addSubview(lastSeenEpisode)
        verticalStack.addSubview(lastSeenEpisodeName)
        verticalStack.addSubview(lastSeenEpisodeAirDate)
        
        characterImage.layer.cornerRadius = 5
        
    }
    
    func configureCharacter(character: CharacterDetail) {
        
        self.characterImage.af.setImage(withURL: URL(string: character.image!)!)
        self.name.text = (character.name)
        self.status.text = Constants.Strings.Status + (character.status!)
        self.species.text = Constants.Strings.Species + (character.species!)
        self.numberOfEpisodes.text = Constants.Strings.Episodes + "\(character.episode?.count ?? 0)"
        self.gender.text = Constants.Strings.Gender + (character.gender!)
        self.originLocation.text = Constants.Strings.Origin_Location + (character.origin?.name!)!
        self.lastKnownLocation.text = Constants.Strings.Known_Location + (character.location?.name!)!
        
    }
    
    func configureEpisode(episode: Episode) {
        
        self.lastSeenEpisode.text = Constants.Strings.Last_Episodes
        self.lastSeenEpisodeName.text = Constants.Strings.Last_Episodes_Name + (episode.name!)
        self.lastSeenEpisodeAirDate.text = Constants.Strings.Last_Episodes_Air_Date + (episode.airDate ?? "")
        
    }
    
    func setUpConstraint() {
        
        characterImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(400)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.bottom.equalTo(view).offset(-5)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(verticalStack.snp.top).offset(10)
        }
        
        status.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(10)
        }
        
        species.snp.makeConstraints { make in
            make.top.equalTo(status.snp.bottom).offset(10)
        }
        
        numberOfEpisodes.snp.makeConstraints { make in
            make.top.equalTo(species.snp.bottom).offset(10)
        }
        
        gender.snp.makeConstraints { make in
            make.top.equalTo(numberOfEpisodes.snp.bottom).offset(10)
        }
        
        originLocation.snp.makeConstraints { make in
            make.top.equalTo(gender.snp.bottom).offset(10)
        }
        
        lastKnownLocation.snp.makeConstraints { make in
            make.top.equalTo(originLocation.snp.bottom).offset(10)
        }
        
        lastSeenEpisode.snp.makeConstraints { make in
            make.top.equalTo(lastKnownLocation.snp.bottom).offset(10)
        }
        
        lastSeenEpisodeName.snp.makeConstraints { make in
            make.top.equalTo(lastSeenEpisode.snp.bottom).offset(10)
        }
        
        lastSeenEpisodeAirDate.snp.makeConstraints { make in
            make.top.equalTo(lastSeenEpisodeName.snp.bottom).offset(10)
        }
    }
}

// MARK: Extension

extension DetailViewController: DetailViewModelOutput {
    
    func selectCharacter(character: CharacterDetail?) {
        configureCharacter(character: character!)
    }
    
    func getEpisodeDetail(episode: Episode?) {
        configureEpisode(episode: episode!)
    }
}
