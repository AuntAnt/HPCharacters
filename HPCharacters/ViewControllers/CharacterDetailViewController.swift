//
//  CharacterDetailViewController.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 25.03.2023.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = 15
        }
    }
    @IBOutlet var alternateNamesLabel: UILabel!
    @IBOutlet var characterHouseLabel: UILabel!
    @IBOutlet var yearOfBirthLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!
    
    var character: Character!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = character.name
        
        setAlternateNamesLabel()
        setHouseLabel()
        setBirthYearLabel()
        setActorLabel()
        
        guard let imageUrl = URL(string: character.image) else {
            characterImage.image = UIImage(systemName: "person.fill")
            return
        }
        
        characterImage.image = UIImage(data: CacheManager.getDataFromCache(imageUrl)!)
    }
    
    // MARK: - private methods
    private func setAlternateNamesLabel() {
        if character.alternateNames.isEmpty {
            alternateNamesLabel.isHidden = true
        } else {
            alternateNamesLabel.text =
            "Also known as:\n \(character.alternateNames.joined(separator: ",\n"))"
                .replacingOccurrences(of: ",", with: "")
        }
    }
    
    private func setHouseLabel() {
        if character.house == "" {
            characterHouseLabel.isHidden = true
        } else {
            characterHouseLabel.text = "House: \(character.house)"
        }
    }
    
    private func setBirthYearLabel() {
        if let yearOfBirth = character.yearOfBirth {
            yearOfBirthLabel.text = "Year of birth: \(yearOfBirth)"
        } else {
            yearOfBirthLabel.isHidden = true
        }
    }
    
    private func setActorLabel() {
        if character.actorWhoPlayed == "" {
            actorLabel.isHidden = true
        } else {
            actorLabel.text = "Actor: \(character.actorWhoPlayed)"
        }
    }
}
