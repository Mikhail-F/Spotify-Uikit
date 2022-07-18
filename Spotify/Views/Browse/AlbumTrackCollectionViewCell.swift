//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Fastick on 18.07.2022.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
    private let albumTrackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(albumTrackNameLabel)
        addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumTrackNameLabel.frame = CGRect(x: 10, y: 0, width: width - 20, height: 30)
        artistNameLabel.frame = CGRect(x: 10, y: albumTrackNameLabel.bottom, width: width - 20, height: 30)
    }
    
    func configure(viewModel: RecommendedTrackCellViewModel) {
        albumTrackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistrName
    }
}
