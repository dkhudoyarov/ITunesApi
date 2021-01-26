//
//  DetailsViewController.swift
//  ITunesApi
//
//  Created by Денис on 23.01.2021.
//

import UIKit

final class DetailsViewController: UIViewController {

    // MARK: - Properties
    var album: Album!
    var songs: [Album]!

    private lazy var songsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupContraits()
        registerCells()
        songsTableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - Private methods
extension DetailsViewController {
    
    private func registerCells() {
        AlbumTableCell.register(songsTableView)
        SongTableCell.register(songsTableView)
    }
    
    private func setupContraits() {
        view.addSubview(songsTableView)
        songsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            songsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            songsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            songsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return songs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = AlbumTableCell.dequeue(tableView, for: indexPath)
            cell.awakeFromNib()
            cell.configure(withAlbum: album)
            return cell
            
        default:
            let cell = SongTableCell.dequeue(tableView, for: indexPath)
            cell.awakeFromNib()
            cell.configure(withSongs: songs, andIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
