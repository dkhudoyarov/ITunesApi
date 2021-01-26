//
//  NetworkManager.swift
//  ITunesApi
//
//  Created by Денис on 25.01.2021.
//

import Foundation

enum MusicType {
    case album
    case song
}

protocol NetworkManagerProtocol {
    func fetchUserData(withKey key: String, musicType: MusicType, completion: @escaping (Result<ITunesResult, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private let networkDataFetcher: DataFetcherProtocol = NetworkDataFetcher()
    
    private init() {}
      
    func fetchMusic(withKey key: String, musicType: MusicType, completion: @escaping (ITunesResult) -> Void) {
        fetchUserData(withKey: key, musicType: musicType) { result in
            switch result {
            case .success( let iTunesResult):
                completion(iTunesResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUserData(withKey key: String, musicType: MusicType, completion: @escaping (Result<ITunesResult, Error>) -> Void) {
        
        var urlString = ""
        
        switch  musicType {
        case .album:
            urlString = ApiBuilder.getAlbum(withKey: key)
        case .song:
            urlString = ApiBuilder.getSong(withKey: key)
        }
        networkDataFetcher.fetchGenericJSONData(fromUrl: urlString, completion: completion)
    }
}
