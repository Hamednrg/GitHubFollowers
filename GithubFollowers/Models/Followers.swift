//
//  Followers.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation

struct Follower: Identifiable, Codable, Hashable {
    var id: Int
    var login: String
    var avatarUrl: String
}
