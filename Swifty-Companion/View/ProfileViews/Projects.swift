//
//  Projects.swift
//  Swifty-Companion
//
//  Created by jules bernard on 18.01.26.
//


import SwiftUI

struct Projects: View {
    @State var showDetails: Bool = false
    let user: User
    
    var body: some View {
        CardView(title: "Projects",
                 content: {
            if let projects = user.projectsUsers {
                VStack(alignment: .leading) {
                    ForEach(showDetails ? projects : Array(projects.prefix(3)), id: \.project.name) { pu in
                        HStack {
                            Text(pu.project.name.capitalized)
                            Spacer()
                            if let mark = pu.finalMark {
                                Text("\(mark)")
                                    .foregroundColor(pu.validated == true ? .accent : .red)
                            }
                            else {
                                Text("...")
                            }
                        }
                        .padding(.top, 2)
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
