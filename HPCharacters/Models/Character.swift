//
//  Person.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 21.03.2023.
//

import Foundation

struct Character: Decodable {
    let name: String
    let actorWhoPlayed: String
    let alternateNames: [String]
    let house: String
    let yearOfBirth: Int?
    let image: String
}

extension Character {
    enum CodingKeys: String, CodingKey {
        case name, house, yearOfBirth, image
        case alternateNames = "alternate_names"
        case actorWhoPlayed = "actor"
    }
}
