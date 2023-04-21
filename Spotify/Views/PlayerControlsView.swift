//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Fastick on 21.07.2022.
//

import UIKit



struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

class PlayerControlsView: UIView {
    
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        slider.maximumValue = 1
        slider.minimumValue = 0
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        backButton.setImage(image, for: .normal)
        return backButton
    }()
    
    private let forwardButton: UIButton = {
        let backButton = UIButton()
        backButton.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        backButton.setImage(image, for: .normal)
        return backButton
    }()
    
    private let playPauseButton: UIButton = {
        let backButton = UIButton()
        backButton.tintColor = .label
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        backButton.setImage(image, for: .normal)
        return backButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_ :)), for: .touchUpInside)
        addSubview(backButton)
        addSubview(playPauseButton)
        addSubview(forwardButton)
        
        backButton.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(onPlayPauseTapButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(onForwardTapButton), for: .touchUpInside)

        clipsToBounds = true
    }
    
    func configure(_ model: PlayerControlsViewViewModel) {
        nameLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
    @objc  private func didSlideSlider(_ slider: UISlider) {
        delegate?.playerControlsView(self, didSlideSlider: slider.value)
    }
    
    @objc private func onTapBackButton() {
        delegate?.playerControlsViewDidTapBackwordsButton(self)
    }
    
    @objc private func onPlayPauseTapButton() {
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
        
        // Обновление иконки
        let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func onForwardTapButton() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom, width: width, height: 50)
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom, width: width - 20, height: 80)
        backButton.frame = CGRect(x: 0, y: volumeSlider.bottom, width: width / 3, height: 50)
        playPauseButton.frame = CGRect(x: backButton.right, y: volumeSlider.bottom, width: width / 3, height: 50)
        forwardButton.frame = CGRect(x: playPauseButton.right, y: volumeSlider.bottom, width: width / 3, height: 50)
    }
    
}
