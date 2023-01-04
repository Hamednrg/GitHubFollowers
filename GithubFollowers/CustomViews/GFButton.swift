//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct GFButton: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
    }
}

extension View {
    func gfButtonStyle(backgroundColor: Color) -> some View {
        modifier(GFButton(backgroundColor: backgroundColor))
    }
}
