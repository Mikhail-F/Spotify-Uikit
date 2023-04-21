//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Fastick on 30.06.2022.
//

import UIKit
import SDWebImage

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwordsButton(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_  playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    
    weak var delegate: PlaybackPresenterDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.configure(PlayerControlsViewViewModel(title: dataSource?.songName ?? "-", subtitle: dataSource?.subtitle ?? "-"))
        controlsView.delegate = self
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.heigth/2)
        controlsView.frame = CGRect(x: 10, y: imageView.bottom + 10, width: view.width - 20, height: view.heigth - imageView.heigth - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL)
        controlsView.configure(PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction() {
        
    }
    
    func refreshUI() {
        configure()
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        print("Stop/Play")
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        print("Next")
        delegate?.didTapForward()
    }
    
    func playerControlsViewDidTapBackwordsButton(_ playerControlsView: PlayerControlsView) {
        print("Back")
        delegate?.didTapBackward()
    }
    
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
}
