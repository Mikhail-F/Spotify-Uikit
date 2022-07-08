//
//  ApiCaller.swift
//  Spotify
//
//  Created by Fastick on 30.06.2022.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    struct Constans {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(comletion: @escaping(Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constans.baseAPIURL + "/me"), type: .GET) { baseRequest in
            URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    comletion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(1)
                    comletion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    comletion(.failure(error))
                }
            }.resume()
        }
    }
    
    public func getNewReleases(comletion: @escaping(Result<NewRelisesResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constans.baseAPIURL + "/browse/new-releases?limit=1"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    comletion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(NewRelisesResponse.self, from: data)
//                    print(json)
                    comletion(.success(result))
                } catch {
                    comletion(.failure(error))
                }
            }.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping(Result<FeaturedPlaylistsResponse, Error>) ->  Void) {
        createRequest(with: URL(string: Constans.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(json)
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    public func getRecomendations(genres: Set<String>, completion: @escaping(Result<RecommendationsResponse, Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constans.baseAPIURL + "/recommendations?limit=2&seed_genres=\(seeds)"), type: .GET, completion: { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }.resume()
        })
    }
    
    public func getRecomendedGenres(completion: @escaping(Result<RecommendedGenresResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constans.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    // MARK - private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiUrl = url else {
                return
            }
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
