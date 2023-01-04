//
//  UserViewModel.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation


@MainActor class UserViewModel: ObservableObject {
    
    @Published private(set) var user: User = User(id: 0, login: "", avatarUrl: "", htmlUrl: "", following: 0, followers: 0)
    @Published private(set) var errorMessage: String = ""
    @Published var gitHubProfile: IdentifiableSafariView?
    @Published var isloading = false
    
    func getUserInfo(for username: String) async {
        isloading = true
        let result = await NetworkManager.shared.getUserInfo(for: username)
        
        switch result {
            case .success(let newUser):
                user = newUser
            case .failure(let error): errorMessage = error.rawValue
        }
        
        isloading = false
    }
    
    func didTapGitHubProfile() {
        guard let url = URL(string: user.htmlUrl) else {
            errorMessage = "The URL attached to this user is invalid"
            return
        }
        
        gitHubProfile = IdentifiableSafariView(id: "github-profile", safari: {
            SafariViewWrapper(url: url)
        })
    }
}
