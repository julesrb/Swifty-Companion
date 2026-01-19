//
//  StudentView.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//


import SwiftUI

struct StudentView: View {
    @State var user: User?
    @State var errorMessage: String = "Enter a existing to search"

    var body: some View {
        
        VStack {
            SearchBar(user: $user, errorMessage: $errorMessage)
            if let user {
                GenericInfo(user: user)
                Level(user: user)
                Skills(user: user)
                Projects(user: user)
            } else {
                Text(errorMessage)
                    .padding(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
}

#Preview {
    MockStudentView()
}
