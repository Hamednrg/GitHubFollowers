//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

enum ItemInfoTypes {
    case followers, following
}

struct GFItemInfoView: View {
    var itemType: ItemInfoTypes
    var count: Int
    
    var label: String {
        switch itemType {
            case .followers:
                return "Followers"
            case .following:
                return "Following"
        }
    }
    
    var image: String {
        switch itemType {
            case .followers:
                return SFSymbols.followers
            case .following:
                return SFSymbols.following
        }
    }
    
    var body: some View {
        VStack {
            Label(label, systemImage: image)
            Text("\(count)")
        }
        .fontWeight(.bold)
        .font(.subheadline)
    }
}

struct GFItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GFItemInfoView(itemType: .followers, count: 10)
    }
}
