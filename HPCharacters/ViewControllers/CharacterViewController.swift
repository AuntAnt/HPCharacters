//
//  ViewController.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 21.03.2023.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    private let baseUrl = "https://hp-api.onrender.com/api/characters"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }

    private func fetchCharacters() {
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let characters = try decoder.decode([Person].self, from: data)
                print(characters)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

