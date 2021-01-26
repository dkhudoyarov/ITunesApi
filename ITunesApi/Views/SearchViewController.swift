//
//  SearchViewController.swift
//  ITunesApi
//
//  Created by Денис on 23.01.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    var router: RouterProtocol?
    private var albums: [Album]?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        CollectionViewCell.register(collectionView)
        navigationItem.titleView = searchBar
        setupConstraits()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - Private methods
extension SearchViewController {
    private func setupConstraits() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                  heightDimension: .absolute(230))
            )
            item.contentInsets.trailing = 16
            item.contentInsets.bottom = 16
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .estimated(500)),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.top = 16
            
            return section
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request = searchBar.text ?? ""
        StorageManager.shared.saveRequests(with: request)
        
        NetworkManager.shared.fetchMusic(withKey: request, musicType: .album) { [weak self] iTunesResult in
            guard let self = self else { return }
            self.albums = iTunesResult.results?.sorted(by: <)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        searchBar.endEditing(true)
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.searchTextField.text = ""
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let albumResult = albums {
            return albumResult.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewCell.dequeue(collectionView, cellForItemAt: indexPath)
        
        let resultElement = albums?[indexPath.row]
        cell.configure(withAlbum: resultElement)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let navigationController = navigationController else { return }
        
        let album = albums?[indexPath.row]
        let key = album?.collectionName ?? ""
        
        NetworkManager.shared.fetchMusic(withKey: key, musicType: .song) { [weak self] iTunesResult in
            guard let self = self else { return }
            let songs = Converter.getUniqueAlbums(fromAlbums: iTunesResult.results)
            DispatchQueue.main.async {
                self.router?.showDetail(album: album, songs: songs, navigationController: navigationController)
            }
        }
    }
}
