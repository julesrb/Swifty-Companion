//
//  Skills.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//


import SwiftUI

struct Skills: View {
    @State var showDetails: Bool = false
    let user: User

    
    var body: some View {
        
        CardView(title: "Skills",
                 content: {
                VStack(alignment: .leading) {
                    ForEach(user.skills.sorted { $0.id < $1.id }, id: \.id) { skill in
                        ProgressView(value: skill.level / 21) {
                            if showDetails {
                                HStack {
                                    Text(skill.name)
                                    Spacer()
                                    Text(String(format: "%.2f", skill.level))
                                }
                                .padding(.top, 6)
                            }
                        }
                    }
                }
            
        }, sideContent: {
            Button(showDetails ? "–" : "+") {
                showDetails.toggle()
            }
            .frame(width: 32, height: 32)
            .background(.white.opacity(0.3))
            .cornerRadius(16)
        })
    }
}

#Preview {
    MockUserView()
}
