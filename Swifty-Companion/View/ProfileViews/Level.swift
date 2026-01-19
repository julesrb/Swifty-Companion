//
//  Level.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//


import SwiftUI

struct Level: View {
    let user: User
    
    var body: some View {
        let level = user.level ?? 0.0
        let percent = level / 21
        
        CardView(title: "Level",
                 content: {
            ProgressView(value: percent)
            HStack {
                Text("0")
                Spacer()
                Text("21")
            }
            
        }, sideContent: {
            Text(String(format: "%.2f", level))
        })
    }
}

#Preview {
    MockUserView()
}
