//
//  api42VM.swift
//  Swifty-Companion
//
//  Created by jules bernard on 19.01.26.
//

import Foundation


class Api42Service {

    static func loadMyProfile(token: Token) async throws -> User {
        let url = URL(string: "https://api.intra.42.fr/v2/me")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            return try JSONDecoder().decode(User.self, from: data)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.noNetwork
        } catch {
            throw error
        }
    }
    

    static func loadStudentProfile(login: String, token: Token) async throws -> User {
        let normalizedLogin = login.lowercased()
        
        var components = URLComponents(string: "https://api.intra.42.fr/v2/users")!
        components.queryItems = [
            URLQueryItem(name: "filter[login]", value: normalizedLogin),
            URLQueryItem(name: "page[size]", value: "1")]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let data: Data
        do {
            let (incomingData, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            data = incomingData
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.noNetwork
        } catch {
            throw error
        }
        
        // Debug print of incoming Json
        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(
                withJSONObject: jsonObject,
                options: [.prettyPrinted]
           ),
           let jsonString = String(data: prettyData, encoding: .utf8) {
            print(jsonString)
        }
        
        let users = try JSONDecoder().decode([User].self, from: data)
        
        guard let userId = users.first?.id else {
            throw NetworkError.userNotFound
        }
        return try await loadUserById(id: userId, token: token)
    }
    
    static func loadUserById(id: Int, token: Token) async throws -> User {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            return try JSONDecoder().decode(User.self, from: data)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.noNetwork
        } catch {
            throw error
        }
    }
}
