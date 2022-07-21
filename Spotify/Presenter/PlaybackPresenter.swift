//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Fastick on 21.07.2022.
//

import UIKit

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        vc.title = "Tracks"
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
