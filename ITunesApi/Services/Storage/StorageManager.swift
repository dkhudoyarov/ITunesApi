//
//  StorageManager.swift
//  ITunesApi
//
//  Created by Денис on 26.01.2021.
//

import Foundation

protocol StorageManagerProtocol {
    func fetchRequests() -> [String]
    func saveRequests(with request: String)
}

final class StorageManager: StorageManagerProtocol {
    
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    private let requestKey = "request"
    
    private init() {}
    
    func fetchRequests() -> [String] {
        if let requests = userDefaults.value(forKey: requestKey) as? [String] {
            return requests
        }
        return []
    }
    
    func saveRequests(with request: String) {
        var requests = fetchRequests()
        requests.append(request)
        userDefaults.set(requests, forKey: requestKey)
    }
}
