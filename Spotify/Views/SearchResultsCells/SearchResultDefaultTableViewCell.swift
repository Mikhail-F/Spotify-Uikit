//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Fastick on 20.07.2022.
//

import UIKit
import SDWebImage

class SearchResultDefaultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator // Добавляет индикатор в правом углу
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame  = CGRect(x: 10, y: 5, width: heigth - 10, height: heigth - 10)
        iconImageView.layer.cornerRadius = iconImageView.heigth / 2
        iconImageView.layer.masksToBounds = true
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: width - iconImageView.width - 15, height: heigth)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    func configure(_ model: SearchResultDefaultTableViewCellViewModel)  {
        label.text = model.title
        iconImageView.sd_setImage(with: model.imageURL)
    }
}
