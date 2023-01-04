//
//  FollowerViewModel.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

@MainActor class FollowerViewModel: ObservableObject {
    
    var allFollowers: [Follower] = []
    
    
    @Published var selectedFollower: Follower?
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var isLoading = false
    @Published var username = ""
    
    
    func getFollowers(for username: String) async  {
       
        isLoading = true
        
            let result = await NetworkManager.shared.getFollowers(for: username)
            
            switch result {
                case .success(let newFollowers):
                    allFollowers.append(contentsOf: newFollowers)
                case .failure(let error): errorMessage = error.rawValue
            }
            
            isLoading = false
    
      
    }
    
    func selectFollower(_ follower: Follower) {
        selectedFollower = follower
    }
    
    func didTapGitHubFollowers(from username: String) async {
        selectedFollower = nil
        allFollowers.removeAll()
        
        await getFollowers(for: username)
    }
}
