//
//  NetworkDataFetcher.swift
//  ITunesApi
//
//  Created by Денис on 25.01.2021.
//

import Foundation

protocol DataFetcherProtocol {
    func fetchGenericJSONData<T: Decodable>(fromUrl urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkDataFetcher: DataFetcherProtocol {
    
    private let requestManager: RequestProtocol
    
    init(requestManager: RequestProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func fetchGenericJSONData<T>(fromUrl urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        requestManager.request(fromUrl: urlString) { [weak self] (data, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            guard let data = data else { return }
            guard let decoded = self.decodeJSONData(forType: T.self, from: data) else { return }
            completion(.success(decoded))
        }
    }
    
    private func decodeJSONData<T: Decodable>(forType type: T.Type, from data: Data) -> T? {
        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch let error {
            print(error)
            return nil
        }
    }
}
