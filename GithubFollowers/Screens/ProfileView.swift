//
//  ProfileView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var userViewModel = UserViewModel()
    
    @State private var showingFollower = false
    @State private var showingFollowing = false
    
    @Binding var username: String
    
    var body: some View {
        ZStack{
            if userViewModel.user.login.isEmpty && !userViewModel.isloading {
                
                GFEmptyView(message: "We couldn't find this user.")
                    
            }else {
                VStack {
                    userHeaderInfo
                    
                    itemOne
                    
                    itemTwo
                        .padding(.top)
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            }
        }
        .redacted(reason: userViewModel.isloading ? .placeholder : [])
        .task {
            await userViewModel.getUserInfo(for: username)
        }
        .onChange(of: username, perform: { newValue in
                Task{
                    await userViewModel.getUserInfo(for: newValue)
                }
                
            })
        .fullScreenCover(item: $userViewModel.gitHubProfile) { profile in
            profile.safari()
        }
        .sheet(isPresented: $showingFollower, content: {
            FollowerListView(username: $username)
        })
        .sheet(isPresented: $showingFollowing, content: {
            FollowingListView(username: $username)
        })
        .navigationTitle(userViewModel.user.name ?? "")
        
    }
    
    var userHeaderInfo: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: userViewModel.user.avatarUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("avatar-placeholder")
                        .resizable()
                        .scaledToFit()
                }
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(userViewModel.user.login)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(userViewModel.user.name ?? "")
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Label(userViewModel.user.location ?? "No Location", systemImage: SFSymbols.location)
                        .foregroundColor(.secondary)
                        .fontWeight(.medium)
                }
                
                Spacer()
            }
            .frame(height: 100)
            
            Text(userViewModel.user.bio ?? "")
                .lineLimit(3)
                .foregroundColor(.secondary)
                .padding([.top, .bottom])
                .multilineTextAlignment(.leading)
        }
    }
    
    var itemOne: some View {
        VStack {
            HStack {
                Button {
                    userViewModel.didTapGitHubProfile()
                } label: {
                    Text("GitHub Profile")
                        .padding()
                        .frame(height: 44)
                        .gfButtonStyle(backgroundColor: .purple)
                }
                .padding(.top)
            }
            .padding()
            .cornerRadius(18)
            .background {
                Color(uiColor: .secondarySystemBackground)
                    .cornerRadius(18)
            }
        }
    }
    
    var itemTwo: some View {
        VStack {
            HStack {
                GFItemInfoView(itemType: .followers, count: userViewModel.user.followers)
                
                Spacer()
                
                GFItemInfoView(itemType: .following, count: userViewModel.user.following)
            }
            
            Button {
                showingFollower.toggle()
            } label: {
                Text("GitHub Followers")
                    .padding()
                    .frame(height: 44)
                    .gfButtonStyle(backgroundColor: .green)
            }
            .padding(.top)
            
            Button {
                showingFollowing.toggle()
            } label: {
                Text("GitHub Following")
                    .padding()
                    .frame(height: 44)
                    .gfButtonStyle(backgroundColor: .green)
            }
            .padding(.top)
        }
        .padding()
        .cornerRadius(18)
        .background {
            Color(uiColor: .secondarySystemBackground)
                .cornerRadius(18)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(username: .constant("hamednrg"))
    }
}
