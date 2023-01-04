//
//  UtilitesView.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import SwiftUI

struct IdentifiableAlert: Identifiable {
    var id: String
    var alert: () -> Alert
}

struct IdentifiableSafariView: Identifiable {
    var id: String
    var safari: () -> SafariViewWrapper
}
