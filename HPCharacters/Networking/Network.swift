//
//  Network.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 23.03.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Just for practice, currently not needed in this app
    func fetch<T: Decodable>(to type: T.Type, from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    ///Getting characters
    func fetchCharacters(from url: URL, completion: @escaping(Result<[Character], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let students = try decoder.decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(students))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    ///Getting image
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

enum Link {
    case characters
    case students
    
    var url: URL {
        switch self {
        case .characters:
            return URL(string: "https://hp-api.onrender.com/api/characters")!
        case .students:
            return URL(string: "https://hp-api.onrender.com/api/characters/students")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}
