//
//  ProfileView.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//


import SwiftUI

struct UserView: View {
    @State var user : User?
    @State private var errorMessage: String?
    @EnvironmentObject var loginVM : LoginVM

    var body: some View {
        VStack {
            if let user {
                Text("Hello \(user.firstname)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                GenericInfo(user: user)
                Level(user: user)
                Skills(user: user)
                Projects(user: user)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .task {
            await loadUser()
        }
    }
    
    func loadUser() async {
        let api = Api42VM()
        do {
            if let token = loginVM.token?.access_token {
                user = try await api.loadMyProfile(token: token)
            }
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage ?? "")
        }
    }
}

#Preview {
    MockUserView()
}



