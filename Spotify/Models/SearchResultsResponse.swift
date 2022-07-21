//
//  SearchResults.swift
//  Spotify
//
//  Created by Fastick on 18.07.2022.
//

import Foundation

struct SearchResultsResponse: Codable {
    let albums: SearchAllbumResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTracksResponse
}

struct SearchAllbumResponse: Codable {
    let items: [Album]
}

struct SearchArtistsResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistsResponse: Codable {
    let items: [Playlist]
}

struct SearchTracksResponse: Codable {
    let items: [AudioTrack]
}
