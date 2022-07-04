//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Fastick on 04.07.2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
