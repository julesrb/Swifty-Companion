//
//  HomeView.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//

import SwiftUI

enum SelectedTab {
    case user
    case student
}

struct AppView: View {
    @State var selectedTab : SelectedTab = SelectedTab.user
    
    var body: some View {
        TabView() {
            Tab("My Profile", systemImage: "person.fill") {
                ScrollView() {
                    UserView()
                }
                .background(Color(red: 137/255, green: 144/255, blue: 137/255))
            }
            Tab("Search", systemImage: "person.crop.badge.magnifyingglass") {
                ScrollView() {
                    StudentView()
                }
                .background(Color(red: 137/255, green: 144/255, blue: 137/255))
            }
        }
    }
}


#Preview {
    AppView()
        .environmentObject(LoginVM())
}
