//
//  SearchBar.swift
//  Swifty-Companion
//
//  Created by jules bernard on 11.11.25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var user: User?
    @Binding var errorMessage: String
    @State var name : String = ""
    @EnvironmentObject var loginVM : LoginVM
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading, 16)
                .padding(.trailing, 0)
            
            TextField("Search Student", text: $name)
                .padding(12)
                .foregroundColor(.white)
                .onSubmit {
                    Task { await loadUser(login: name) }
                }
        }
        .background(Color.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    func loadUser(login: String) async {
        let api = Api42VM()
        do {
            if let token = loginVM.token?.access_token {
                user = try await api.loadStudentProfile(login: login, token: token)
            }
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
        }
    }
}

#Preview {
    MockStudentView()
}
