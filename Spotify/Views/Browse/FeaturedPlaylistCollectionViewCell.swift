//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Fastick on 06.07.2022.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistCoverImageView)
        addSubview(playlistNameLabel)
        addSubview(creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = CGRect(x: 3, y: contentView.heigth - 33, width: contentView.width - 6, height: 30)
        playlistNameLabel.frame = CGRect(x: 3, y: contentView.heigth - 66, width: contentView.width  - 6, height: 30)
        let imageSize = contentView.heigth - 70
        playlistCoverImageView.frame = CGRect(x: (contentView.width - imageSize) / 2, y: 3, width: imageSize, height: imageSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        creatorNameLabel.text = nil
        playlistNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(viewModel: FeaturedPlaylistCellViewModel) {
        creatorNameLabel.text = viewModel.creatorName
        playlistNameLabel.text = viewModel.name
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
