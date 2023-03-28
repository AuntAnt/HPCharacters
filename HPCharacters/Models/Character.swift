//
//  Person.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 21.03.2023.
//

import Foundation

struct Character {
    let name: String
    let actorWhoPlayed: String
    let alternateNames: [String]
    let house: String
    let yearOfBirth: Int?
    let image: String
    
    init(from data: [String: Any]) {
        name = data["name"] as? String ?? ""
        actorWhoPlayed = data["actor"] as? String ?? ""
        alternateNames = data["alternate_names"] as? [String] ?? []
        house = data["house"] as? String ?? ""
        yearOfBirth = data["yearOfBirth"] as? Int
        image = data["image"] as? String ?? ""
    }
    
    static func getAllCharacters(from data: Any) -> [Character] {
        guard let loadedCharacters = data as? [[String: Any]] else { return [] }
        return loadedCharacters.map { Character(from: $0) }
    }
}
