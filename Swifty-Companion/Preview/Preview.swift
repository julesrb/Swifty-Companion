//
//  Preview.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//

import SwiftUI

func MockUserView() -> some View {
    
    return UserView(user: loadLocalUser())
        .environmentObject(LoginVM())
        .background(Color(red: 137/255, green: 144/255, blue: 137/255))
}

func MockStudentView() -> some View {
    
    return StudentView(user: loadLocalUser())
        .environmentObject(LoginVM())
        .background(Color(red: 137/255, green: 144/255, blue: 137/255))
}

func loadLocalUser() -> User? {
    guard let url = Bundle.main.url(forResource: "local_user", withExtension: "json") else {
        print("local_user.json not found in bundle")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: data)
    } catch {
        print("Error decoding local_user.json: \(error)")
        return nil
    }
}
