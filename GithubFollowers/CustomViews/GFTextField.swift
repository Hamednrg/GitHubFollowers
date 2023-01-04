//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct GFTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .accentColor(.init(uiColor: .label))
            .multilineTextAlignment(.center)
            .font(.title2)
            .background(Color(uiColor: .tertiarySystemBackground))
            .disableAutocorrection(true)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .systemGray4), lineWidth: 2)
            )
    }
}

extension View {
    func gfTextFieldStyle() -> some View {
        modifier(GFTextField())
    }
}
