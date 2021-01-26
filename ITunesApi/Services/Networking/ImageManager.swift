//
//  ImageManager.swift
//  ITunesApi
//
//  Created by Денис on 25.01.2021.
//

import Foundation

//protocol ImageManagerProtocol {
//    func getImagesData(from photos: [Photo]) -> [Data]?
//}

protocol ImageManagerProtocol {
    func getImage(fromUrl: String) -> Data?
}

final class ImageManager: ImageManagerProtocol {
    static let shared = ImageManager()
    private init() {}
    
    func getImage(fromUrl: String) -> Data? {
        guard let imageURL = URL(string: fromUrl) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}
