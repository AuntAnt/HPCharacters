//
//  Person.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 21.03.2023.
//

import Foundation

struct Character: Decodable {
    let name: String
    let actor: String
    let alternateNames: [String]
    let species: String
    let gender: String
    let house: String
    let yearOfBirth: Int?
    let image: String
}

//extension Character {
//    enum CodingKeys: String, CodingKey {
//        case name
//        case
//    }
//}
