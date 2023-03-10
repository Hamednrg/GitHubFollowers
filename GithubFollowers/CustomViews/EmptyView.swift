//
//  EmptyView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct GFEmptyView: View {
    let message: String
    
    var body: some View {
        ZStack {
            Image("empty-view")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 450)
                .offset(x: 140, y: 210)
            
            VStack {
                Spacer()
                
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(.secondary)
                    .bold()
                    .padding(.horizontal, 60)
                
                Spacer()
                Spacer()
            }
        }
    }
}

struct GFEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        GFEmptyView(message: "This user doesn't have any followers.")
    }
}
