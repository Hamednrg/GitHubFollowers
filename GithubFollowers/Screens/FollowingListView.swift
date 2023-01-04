//
//  FollowingListView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation
import SwiftUI

struct FollowingListView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var followingViewModel = FollowingViewModel()
    @Binding var username: String
    
    var body: some View {
        NavigationView {
            
            ZStack{
                if followingViewModel.allFollowing.isEmpty && !followingViewModel.isLoading {
                    GFEmptyView(message: "This user doesn't have any following.")
                } else {
                    List{
                        ForEach(followingViewModel.allFollowing) { following in
                            FollowerView(follower: following)
                                .onTapGesture {
                                    Task {
                                        await followingViewModel.didTapGitHubFollowing(from: following.login)
                                        username = following.login
                                        dismiss()
                                    }
                                }
                        }
                    }
                    
                }
                
            }
            .redacted(reason: followingViewModel.isLoading ? .placeholder : [])
            .task {
                await followingViewModel.getFollowing(for: username)
            }
            .navigationTitle("Following")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListView(username: .constant("hamednrg"))
    }
}
