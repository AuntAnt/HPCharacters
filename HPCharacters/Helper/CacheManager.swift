//
//  CacheManager.swift
//  HPCharacters
//
//  Created by Anton Kuzmin on 25.03.2023.
//

import Foundation

final class CacheManager {
    private static let shared = CacheManager()
    
    private var dataCache: [URL: Data]
    
    private init() {
        dataCache = [:]
    }
    
    static func setDataCache(_ url: URL, _ data: Data) {
        shared.dataCache[url] = data
    }
    
    static func getDataFromCache(_ url: URL) -> Data? {
        shared.dataCache[url]
    }
}
