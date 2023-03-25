//
//  CharacterCell.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 25.03.2023.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!
    @IBOutlet var houseLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        actorLabel.text = character.actor
        houseLabel.text = character.house
        
        if let imageURL = URL(string: character.image) {
            networkManager.fetchImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let imageData):
                    self?.characterImage.image = UIImage(data: imageData)
                case .failure(let error):
                    self?.characterImage.image = UIImage(systemName: "person.fill")
                    print(error)
                }
            }
        } else {
            characterImage.image = UIImage(systemName: "person.fill")
        }
    }
}
