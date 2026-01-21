//
//  NetworkError.swift
//  Swifty-Companion
//
//  Created by Antigravity on 21.01.26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case userNotFound
    case noNetwork
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "User Not Found"
        case .noNetwork:
            return "No network connection. Please check your internet."
        case .invalidResponse:
            return "Invalid response from server"
        }
    }
}
