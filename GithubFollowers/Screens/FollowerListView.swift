//
//  FollowerListView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct FollowerListView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var followerViewModel = FollowerViewModel()
    @Binding var username: String
    
    var body: some View {
        NavigationView {
            ZStack{
                if followerViewModel.allFollowers.isEmpty && !followerViewModel.isLoading {
                    GFEmptyView(message: "This user doesn't have any follower.")
                }else {
                    List{
                        ForEach(followerViewModel.allFollowers) { follower in
                            FollowerView(follower: follower)
                                .onTapGesture {
                                    Task {
                                        await followerViewModel.didTapGitHubFollowers(from: follower.login)
                                        username = follower.login
                                        dismiss()
                                    }
                                }
                        }
                    }
                }
            }
            .redacted(reason: followerViewModel.isLoading ? .placeholder : [])
            .task {
                await followerViewModel.getFollowers(for: username)
            }
            .navigationTitle("Followers")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerListView(username: .constant("hamednrg"))
    }
}
