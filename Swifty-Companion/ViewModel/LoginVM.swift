//
//  LoginVM.swift
//  Swifty-Companion
//
//  Created by jules bernard on 19.01.26.
//

import Combine
import Foundation
import AuthenticationServices

@MainActor
class LoginVM : NSObject, ObservableObject {
    static let uid: String = APISecrets.uid
    static let secret: String = APISecrets.secret
    static let redirect_uri : String = "swiftycompanion://oauth/callback"
    private var authCode : String?
    let url : String = "https://api.intra.42.fr/oauth/authorize?" +
                  "client_id=\(uid)&" +
                  "redirect_uri=\(redirect_uri)&" +
                  "response_type=code&" +
                  "scope=public"
    
    @Published var token : Token?
    
    @MainActor
    func login() async throws {
        let session = ASWebAuthenticationSession(url: URL(string: url)!, callbackURLScheme: "swiftycompanion") { callbackURL, error in

            if let error = error {
                print("Login cancelled or failed:", error)
                return
            }

            guard
                let url = callbackURL,
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                let code = components.queryItems?
                    .first(where: { $0.name == "code" })?.value
            else {
                print("No code in callback")
                return
            }
            self.authCode = code
            Task {
                try await self.exchangeCodeForToken()
            }
        }

        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
    }
    
    func exchangeCodeForToken() async throws {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
        
        guard let authCode else { return }

        let body =
            "grant_type=authorization_code&" +
            "client_id=\(Self.uid)&" +
            "client_secret=\(Self.secret)&" +
            "code=\(authCode)&" +
            "redirect_uri=\(Self.redirect_uri)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            self.token = try JSONDecoder().decode(Token.self, from: data)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.noNetwork
        } catch {
            throw error
        }
    }

    func getValidToken() async throws -> Token {
        guard let token = self.token else {
            throw NetworkError.invalidResponse // Or a specific NotLoggedIn error
        }
        
        if token.isExpired {
            print("Token expired, attempting renewal...")
            try await exchangeCodeForToken()
            guard let newToken = self.token else {
                throw NetworkError.invalidResponse
            }
            return newToken
        }
        
        return token
    }
}

extension LoginVM: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.windows.first!
    }
}
