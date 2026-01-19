//
//  CardView.swift
//  Swifty-Companion
//
//  Created by jules bernard on 16.01.26.
//

import SwiftUI


struct CardView<SideContent: View, Content: View>: View {
    let title: String
    let content: Content
    let sideContent: SideContent
    
    init(
        title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder sideContent: () -> SideContent
    ) {
        self.title = title
        self.sideContent = sideContent()
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if !title.isEmpty {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    sideContent
                }
            }
            content
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .foregroundStyle(.white)
        .cornerRadius(24)
    }
}

#Preview {
    MockUserView()
}
