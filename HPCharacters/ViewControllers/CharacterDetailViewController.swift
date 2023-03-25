//
//  CharacterDetailViewController.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 25.03.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
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
        actorLabel.text = "Actor: \(character.actor)"
        
        networkManager.fetchImage(from: URL(string: character.image)!, completion: { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setAlternateNamesLabel() {
        if character.alternateNames.isEmpty {
            alternateNamesLabel.isHidden = true
        } else {
            alternateNamesLabel.text = "Also known as\n \(character.alternateNames.joined(separator: ",\n"))".replacingOccurrences(of: ",", with: "")
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
}
