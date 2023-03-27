//
//  Network.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 23.03.2023.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    ///Getting characters
    func fetchCharacters(from url: URL, completion: @escaping(Result<[Character], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let characters = Character.getAllCharacters(from: value)
                    completion(.success(characters))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    ///Getting image
    func fetchImage(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
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
