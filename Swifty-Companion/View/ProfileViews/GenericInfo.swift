//
//  GenericInfo.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//


import SwiftUI


struct GenericInfo: View {
    let user: User
    
    var body: some View {
        CardView(title: "",
            content: {
            
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: user.image.link)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(user.login.capitalized)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Circle()
                            .foregroundStyle(user.location != nil ? Color.accentColor : .gray)
                            .frame(height: 10)
                        Text(user.location ?? "offline")
                    }
                    Text(user.displayname)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                }
            }
        }, sideContent: {
        })
    }
}

#Preview {
    MockUserView()
}
