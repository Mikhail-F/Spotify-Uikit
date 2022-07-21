//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Fastick on 21.07.2022.
//

import UIKit
import SDWebImage

struct SearchResultSubtitleTableViewCellViewModel {
    let title: String
    let subTitle: String
    let imageURL: URL?
}

class SearchResultSubtitleTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: 10, y: 0, width: heigth - 10, height: heigth - 10)
        titleLabel.frame = CGRect(x: iconImageView.right + 10, y: 0, width: width - iconImageView.width - 15, height: heigth/2)
        subTitleLabel.frame = CGRect(x: iconImageView.right + 10, y: titleLabel.bottom, width: width - iconImageView.width - 15, height: heigth/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subTitleLabel.text = nil
        iconImageView.image = nil
    }
    
    func configure(_ model: SearchResultSubtitleTableViewCellViewModel) {
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        iconImageView.sd_setImage(with: model.imageURL)
    }
    
}
