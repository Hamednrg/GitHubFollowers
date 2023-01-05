//
//  Users.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let htmlUrl: String
    let following: Int
    let followers: Int
}

class UserHolder: NSObject {
    let user: User
    init(user: User) {
           self.user = user
       }
}
