//
//  LoginView.swift
//  Swifty-Companion
//
//  Created by jules bernard on 16.01.26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginVM : LoginVM
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("42_logo")
                .resizable()
                .scaledToFit()
                .padding(.leading, 60)
                .padding(.trailing, 80)
                .padding(.bottom, 20)
            
            Text("COMPANION")
                .font(.largeTitle)
                .foregroundStyle(.white)
            
            Spacer()
            
            Button("Login with 42") {
                Task {
                    try await loginVM.login()
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(16)
            .foregroundStyle(.black)
            
            Spacer(minLength: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 137/255, green: 144/255, blue: 137/255))
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginVM())
}
