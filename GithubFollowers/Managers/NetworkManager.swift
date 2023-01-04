//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com"
    
    private init() {}
    
    func getFollowers(for username: String) async -> Result<[Follower], GFError> {
        let endpoint = baseUrl + "/users/\(username)/followers"
        
        guard let url = URL(string: endpoint) else {
            return .failure(.invalidUsername)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                return .failure(.invalidResponse)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let followers = try decoder.decode([Follower].self, from: data)
            
            return .success(followers)
        } catch {
            return .failure(.unableToComplete)
        }
    }
    
    func getFollowing(for username: String) async -> Result<[Follower], GFError> {
        let endpoint = baseUrl + "/users/\(username)/following"
        
        guard let url = URL(string: endpoint) else {
            return .failure(.invalidUsername)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                return .failure(.invalidResponse)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let followings = try decoder.decode([Follower].self, from: data)
            
            return .success(followings)
        } catch {
            return .failure(.unableToComplete)
        }
    }
    
    func getUserInfo(for username: String) async -> Result<User, GFError> {
        let endpoint = baseUrl + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            return .failure(.invalidUsername)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                return .failure(.invalidResponse)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let user = try decoder.decode(User.self, from: data)
            
            return .success(user)
        } catch {
            return .failure(.unableToComplete)
        }
    }
}
