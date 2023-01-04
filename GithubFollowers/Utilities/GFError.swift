//
//  GFError.swift
//  GithubFollowers
//
//  Created by Hamed Naji on 2023-01-04.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username createad an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "Received invalid data from the server. Please try again."
   
}
