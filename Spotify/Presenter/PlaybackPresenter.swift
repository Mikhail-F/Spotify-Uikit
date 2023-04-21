//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Fastick on 21.07.2022.
//
import AVFoundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? {get}
    var subtitle: String? {get}
    var imageURL: URL? {get}
}

protocol PlaybackPresenterDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        
        return nil
    }
    
    var playerVC: PlayerViewController?
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.dataSource = self
        
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap{
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
           return AVPlayerItem(url: url)
        }
        
        self.playerQueue = AVQueuePlayer(items: items)
//        self.playerQueue?.volume = 0
        self.playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
        self.playerVC = vc
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}


extension PlaybackPresenter: PlaybackPresenterDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else {
                player.play()
            }
        }  else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let player = playerQueue{
            player.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        } else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}
