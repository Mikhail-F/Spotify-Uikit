//
//  SearchResult.swift
//  Spotify
//
//  Created by Fastick on 18.07.2022.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
