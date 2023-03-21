//
//  Person.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 21.03.2023.
//

import Foundation

struct Person: Decodable {
    let name: String
    let alternate_names: [String]
    let species: String
    let gender: String
    let house: String
    let yearOfBirth: Int?
    let image: String
}
