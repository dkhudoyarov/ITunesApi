//
//  Router.swift
//  ITunesApi
//
//  Created by Денис on 23.01.2021.
//

import UIKit

protocol RouterMain {
    var assemblyModule: AssemblyModuleProtocol? { get set }
    var tabBarController: UITabBarController? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(album: Album?, songs: [Album]?, navigationController: UINavigationController)
    func showHistoryAlbums(albums: [Album]?, navigationController: UINavigationController)
}

final class Router: RouterProtocol {
    
    var assemblyModule: AssemblyModuleProtocol?
    var tabBarController: UITabBarController?
    
    init(tabBarController: UITabBarController, assemblyModule: AssemblyModuleProtocol) {
        self.tabBarController = tabBarController
        self.assemblyModule = assemblyModule
    }
    
    func initialViewController() {
        if let tabBarController = tabBarController {
            guard let searchViewController = assemblyModule?.createSearchModule(router: self),
                  let historyViewController = assemblyModule?.createHistoryModule(router: self)
            else { return }
            
            searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
            historyViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
            
            let firstNavigation = UINavigationController(rootViewController: searchViewController)
            let secondNavigation = UINavigationController(rootViewController: historyViewController)
            
            tabBarController.viewControllers = [firstNavigation, secondNavigation]
        }
    }
    
    func showDetail(album: Album?, songs: [Album]?, navigationController: UINavigationController) {
        if let _ = tabBarController {
            guard let detailsViewController = assemblyModule?.createDetailsModule(album: album, songs: songs, router: self) else { return }
            navigationController.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func showHistoryAlbums(albums: [Album]?, navigationController: UINavigationController) {
        if let _ = tabBarController {
            guard let historyAlbumsController = assemblyModule?.createHistoryAlbumsModule(router: self, albums: albums) else { return }
            navigationController.pushViewController(historyAlbumsController, animated: true)
        }
    }
}
