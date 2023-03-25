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
        actorLabel.text = character.actorWhoPlayed
        houseLabel.text = character.house
        
        guard let imageURL = URL(string: character.image) else {
            characterImage.image = UIImage(systemName: "person.fill")
            return
        }
        
        if let imageData = CacheManager.getDataFromCache(imageURL) {
            characterImage.image = UIImage(data: imageData)
        } else {
            networkManager.fetchImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let imageData):
                    CacheManager.setDataCache(imageURL, imageData)
                    self?.characterImage.image = UIImage(data: imageData)
                case .failure(let error):
                    self?.characterImage.image = UIImage(systemName: "person.fill")
                    print(error)
                }
            }
        }
    }
}
