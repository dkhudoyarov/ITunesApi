//
//  AssemblyModule.swift
//  ITunesApi
//
//  Created by Денис on 23.01.2021.
//

import UIKit

protocol AssemblyModuleProtocol {
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createHistoryModule(router: Router) -> UIViewController
    func createDetailsModule(album: Album?, songs: [Album]?, router: RouterProtocol) -> UIViewController
    func createHistoryAlbumsModule(router: RouterProtocol, albums: [Album]?) -> UIViewController
}

final class AssemblyModule: AssemblyModuleProtocol {
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let searchViewController = SearchViewController()
        searchViewController.router = router
        return searchViewController
    }
    
    func createHistoryModule(router: Router) -> UIViewController {
        let historyViewController = HistoryViewController()
        historyViewController.router = router
        return historyViewController
    }
    
    func createDetailsModule(album: Album?, songs: [Album]?, router: RouterProtocol) -> UIViewController {
        let detailsViewController = DetailsViewController()
        detailsViewController.album = album
        detailsViewController.songs = songs
        return detailsViewController
    }
    
    func createHistoryAlbumsModule(router: RouterProtocol, albums: [Album]?) -> UIViewController {
        let historyAlbumsViewController = HistoryAlbumsViewController()
        historyAlbumsViewController.router = router
        historyAlbumsViewController.albums = albums
        return historyAlbumsViewController
    }
}
