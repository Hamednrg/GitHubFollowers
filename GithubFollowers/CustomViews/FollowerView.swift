//
//  FollowerView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct FollowerView: View {
    var follower: Follower
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image("avatar-placeholder")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 100,height: 100)
            .cornerRadius(10)
            
            Text(follower.login)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .padding()
        }
        .padding()
    }
}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerView(follower: Follower(id: 1, login: "hamednrg", avatarUrl: "https://github.com/hamednrg.png"))
    }
}
