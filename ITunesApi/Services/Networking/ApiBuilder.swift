//
//  ApiBuilder.swift
//  ITunesApi
//
//  Created by Денис on 24.01.2021.
//

import Foundation

enum ApiBuilder {
    static func getAlbum(withKey key: String) -> String {
        let filteredKey = key.components(separatedBy: .whitespaces).joined().lowercased()
        return "https://itunes.apple.com/search?term=\(filteredKey)&media=music&entity=album"
    }
    
    static func getSong(withKey key: String) -> String {
        let filteredKey = key.components(separatedBy: .whitespaces).joined().lowercased()
        return "https://itunes.apple.com/search?term=\(filteredKey)&media=music&entity=song"
    }
}
