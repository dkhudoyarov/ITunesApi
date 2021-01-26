//
//  Converter.swift
//  ITunesApi
//
//  Created by Денис on 26.01.2021.
//

import Foundation

struct Converter {
    static func getUniqueAlbums(fromAlbums albums: [Album]?) -> [Album] {
        var seen = Set<String>()
        var songs: [Album] = []

        albums?.forEach {
            if !seen.contains($0.trackName ?? "") {
                songs.append($0)
                seen.insert($0.trackName ?? "")
            }
        }
        return songs
    }
}
