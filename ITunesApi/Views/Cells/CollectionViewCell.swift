//
//  CollectionViewCell.swift
//  ITunesApi
//
//  Created by Денис on 25.01.2021.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "SearchCollectionCell"
    
    private lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods
extension CollectionViewCell {
    func configure(withAlbum album: Album?) {
        guard let album = album else { return }
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        if let imageData = ImageManager.shared.getImage(fromUrl: album.artworkUrl100 ?? "") {
            albumImageView.image = UIImage(data: imageData)
        }
    }
    
    private func setupConstraits() {
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            albumImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 8),
            albumNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            albumNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            artistNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }
    
    static func dequeue(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
        return cell
    }
}
