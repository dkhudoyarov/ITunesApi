//
//  HistoryViewController.swift
//  ITunesApi
//
//  Created by Денис on 23.01.2021.
//

import UIKit

final class HistoryViewController: UIViewController {

    // MARK: - Properties
    var router: RouterProtocol?
    private var albums: [Album]?
    private var requests: [String] = []
    
    private lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraits()
        requests = StorageManager.shared.fetchRequests().reversed()
    }
}

// MARK: - Private methods
extension HistoryViewController {
    private func setupConstraits() {
        view.addSubview(historyTableView)
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.topAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = requests[indexPath.row]
            cell.contentConfiguration = content
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let navigationController = navigationController else { return }
        
        let request = requests[indexPath.row]
        
        NetworkManager.shared.fetchMusic(withKey: request, musicType: .album) { [weak self] iTunesResult in
            guard let self = self else { return }
            self.albums = iTunesResult.results?.sorted(by: <)
            DispatchQueue.main.async {
                self.router?.showHistoryAlbums(albums: self.albums, navigationController: navigationController)
            }
        }
    }
}
