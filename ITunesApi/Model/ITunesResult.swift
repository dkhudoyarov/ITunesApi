//
//  AlbumResult.swift
//  ITunesApi
//
//  Created by Денис on 23.01.2021.
//

import Foundation

struct ITunesResult: Codable {
    let results: [Album]?
}

struct Album: Codable, Hashable {
    let artistName, collectionName, trackName: String?
    let artworkUrl60, artworkUrl100: String?
    let trackCount: Int?
}

extension Album: Comparable {
    static func < (lhs: Album, rhs: Album) -> Bool {
        lhs.collectionName ?? "" < rhs.collectionName ?? ""
    }
    
    static func > (lhs: Album, rhs: Album) -> Bool {
        lhs.collectionName ?? "" > rhs.collectionName ?? ""
    }
    
    static func <= (lhs: Album, rhs: Album) -> Bool {
        lhs.collectionName ?? "" <= rhs.collectionName ?? ""
    }
    
    static func >= (lhs: Album, rhs: Album) -> Bool {
        lhs.collectionName ?? "" >= rhs.collectionName ?? ""
    }
}

