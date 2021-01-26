//
//  SongTableCell.swift
//  ITunesApi
//
//  Created by Денис on 25.01.2021.
//

import UIKit

final class SongTableCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "SongTableCell"
    
    private lazy var rowNumber: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContraits()
    }
}

// MARK: - Methods
extension SongTableCell {
    
    func configure(withSongs songs: [Album], andIndexPath indexPath: IndexPath) {
        rowNumber.text = "\(indexPath.row + 1)"
        songNameLabel.text = songs[indexPath.row].trackName
    }
    
    private func setupContraits() {
        contentView.addSubview(rowNumber)
        contentView.addSubview(songNameLabel)
        
        rowNumber.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rowNumber.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rowNumber.centerXAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            songNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            songNameLabel.leftAnchor.constraint(equalTo: rowNumber.centerXAnchor, constant: 16),
            songNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: identifier)
    }
    
    static func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> SongTableCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SongTableCell else { return SongTableCell() }
        return cell
    }
}
