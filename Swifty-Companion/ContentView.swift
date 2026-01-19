//
//  ContentView.swift
//  Swifty-Companion
//
//  Created by jules bernard on 03.12.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginVM : LoginVM
    
    var body: some View {
        ZStack {
            VStack{}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .background(Color(red: 137/255, green: 144/255, blue: 137/255))
            if loginVM.token != nil {
                AppView()
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    MockUserView()
}
