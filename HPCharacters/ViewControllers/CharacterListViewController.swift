//
//  CharacterListViewController.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 21.03.2023.
//

import UIKit

final class CharacterListViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchCharacters()
        
        fetchCharacters()
        
        tableView.rowHeight = 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterDetailVC = segue.destination as? CharacterDetailViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        characterDetailVC?.character = characters[indexPath.row]
    }
}

// MARK: - Network extension
extension CharacterListViewController {
    private func fetchCharacters() {
        networkManager.fetchCharacters(from: Link.characters.url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.characters = data
                self?.tableView.reloadData()
            case .failure(let error): print(error)
            }
        }
    }
}

// MARK: - Table view extension
extension CharacterListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
}
