//
//  Playlist.swift
//  Spotify
//
//  Created by Fastick on 30.06.2022.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: String
    let id: String
    let images: [ApiImage]
    let name: String
    let owner: User
}
