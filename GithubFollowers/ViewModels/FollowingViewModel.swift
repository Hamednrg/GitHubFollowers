//
//  FollowingViewModel.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation

import SwiftUI

@MainActor class FollowingViewModel: ObservableObject {
    
    var allFollowing: [Follower] = []

    @Published var selectedFollowing: Follower?
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var isLoading = false
    @Published var username = ""
    
    
    func getFollowing(for username: String) async  {
       
        isLoading = true
        
        let result = await NetworkManager.shared.getFollowing(for: username)
        
        
        
        switch result {
            case .success(let newFollowing):
                allFollowing.append(contentsOf: newFollowing)
            case .failure(let error): errorMessage = error.rawValue
        }
        
        isLoading = false
    }
    
    func selectFollower(_ following: Follower) {
        selectedFollowing = following
    }
    
    func didTapGitHubFollowing(from username: String) async {
        selectedFollowing = nil
        allFollowing.removeAll()
        
        await getFollowing(for: username)
    }
}
