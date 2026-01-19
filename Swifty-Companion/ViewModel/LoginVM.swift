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

            Task {
                self.token = try await self.exchangeCodeForToken(code)
            }
        }

        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
    }
    
    func exchangeCodeForToken(_ code: String) async throws -> Token {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!

        let body =
            "grant_type=authorization_code&" +
            "client_id=\(Self.uid)&" +
            "client_secret=\(Self.secret)&" +
            "code=\(code)&" +
            "redirect_uri=\(Self.redirect_uri)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Token.self, from: data)
    }
}

extension LoginVM: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.windows.first!
    }
}
