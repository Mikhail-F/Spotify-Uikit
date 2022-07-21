//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Fastick on 21.07.2022.
//

import UIKit

final class PlaybackPresenter {
    static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        viewController.present(vc, animated: true)
    }
    
    static func startPlayback(from viewController: UIViewController, album: Album) {
        
    }
    
    static func startPlayback(from viewController: UIViewController, playlist: Playlist) {
        let vc = PlayerViewController()
        viewController.present(vc, animated: true)
    }
}
