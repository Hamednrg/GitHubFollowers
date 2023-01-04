//
//  HomeView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct HomeView: View {
    @State private var usernames: [String] = []
    @State private var username: String = ""
    @State private var alertToShow: IdentifiableAlert?
    
    var body: some View {
        NavigationStack(path: $usernames) {
            VStack {
                Spacer()
                
                Image("gh-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 60)
                    .padding(.bottom, 40)
                
                TextField("Enter a username", text: $username, onCommit: {
                    navigateToProfileView()
                })
                .frame(height: 50)
                .gfTextFieldStyle()
                
                Spacer()
                Spacer()
                
                Button {
                    navigateToProfileView()
                } label: {
                    Text("Get Followers")
                        .padding()
                        .frame(height: 50)
                        .gfButtonStyle(backgroundColor: .green)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationDestination(for: String.self) { username in
                ProfileView(username: $username)
            }
            .alert(item: $alertToShow) { alertToShow in
                alertToShow.alert()
            }
        }
    }
    
    private func navigateToProfileView() {
        guard !username.isEmpty else {
            showEmptyUsernameAlert()
            return
        }
        
        usernames.append(username)
    }
    
    private func showEmptyUsernameAlert() {
        alertToShow = IdentifiableAlert(id: "empty-username") {
            Alert(
                title: Text("Empty username"),
                message: Text("Please enter a username."),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
