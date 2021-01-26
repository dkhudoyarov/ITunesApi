//
//  AlbumTableCell.swift
//  ITunesApi
//
//  Created by Денис on 25.01.2021.
//

import UIKit

final class AlbumTableCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "AlbumTableCell"
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContraits()
    }
}

// MARK: - Methods
extension AlbumTableCell {
    func configure(withAlbum album: Album) {
        artistNameLabel.text = album.artistName
        albumNameLabel.text = album.collectionName
        if let imageData = ImageManager.shared.getImage(fromUrl: album.artworkUrl100 ?? "") {
            albumImageView.image = UIImage(data: imageData)
        }
    }
    
    private func setupContraits() {
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(albumImageView)
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//            albumImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 2),
//            albumImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2)
        ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 16),
            albumNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            albumNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            albumNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8),
            artistNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            artistNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            artistNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: identifier)
    }
    
    static func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> AlbumTableCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? AlbumTableCell else { return AlbumTableCell() }
        return cell
    }
}
