//
//  Swifty_CompanionApp.swift
//  Swifty-Companion
//
//  Created by jules bernard on 03.12.25.
//

import SwiftUI

@main
struct Swifty_CompanionApp: App {
    @StateObject var loginVM : LoginVM = LoginVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginVM)
        }
    }
}
