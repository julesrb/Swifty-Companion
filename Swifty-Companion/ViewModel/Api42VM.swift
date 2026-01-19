//
//  api42VM.swift
//  Swifty-Companion
//
//  Created by jules bernard on 19.01.26.
//

import Foundation


class Api42VM {

    func loadMyProfile(token: Token) async throws -> User {
        let url = URL(string: "https://api.intra.42.fr/v2/me")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(User.self, from: data)
    }
    

    func loadStudentProfile(login: String, token: Token) async throws -> User? {
        let normalizedLogin = login.lowercased()
        
        var components = URLComponents(string: "https://api.intra.42.fr/v2/users")!
        components.queryItems = [
            URLQueryItem(name: "filter[login]", value: normalizedLogin),
            URLQueryItem(name: "page[size]", value: "1")]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let users = try JSONDecoder().decode([User].self, from: data)
        guard let userId = users.first?.id else {
            return nil
        }
        return try await loadUserById(id: userId, token: token)
    }
    
    func loadUserById(id: Int, token: Token) async throws -> User {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(User.self, from: data)
    }
}
