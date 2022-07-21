//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Fastick on 06.07.2022.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let recommendedTrackCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let recommendedTrackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(recommendedTrackCoverImageView)
        addSubview(recommendedTrackNameLabel)
        addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.heigth - 4
        recommendedTrackCoverImageView.frame = CGRect(
            x: 10,
            y: 0,
            width: imageSize,
            height: imageSize
        )
        recommendedTrackNameLabel.frame = CGRect(
            x: recommendedTrackCoverImageView.width + 20,
            y: 0,
            width: contentView.width - 20,
            height: contentView.heigth / 2
        )
        artistNameLabel.frame = CGRect(
            x: recommendedTrackCoverImageView.width + 20,
            y: recommendedTrackNameLabel.bottom,
            width: contentView.width - 20,
            height: contentView.heigth / 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistNameLabel.text = nil
        recommendedTrackNameLabel.text = nil
        recommendedTrackCoverImageView.image = nil
    }
    
    func configure(viewModel: RecommendedTrackCellViewModel) {
        artistNameLabel.text = viewModel.artistrName
        recommendedTrackNameLabel.text = viewModel.name
        recommendedTrackCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
