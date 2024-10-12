/*
  RMIT University Vietnam
  Course: COSC2659|COSC2813 iOS Development
  Semester: 2024B
  Assessment: Assignment 1
  Author: Nguyen Ngoc Luong
  ID: S3927460
  Created  date: 01/08/2024
  Last modified: 05/08/2024
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct Tab_View: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24) // Adjust size as needed
                            .padding(8)
                            .background(Circle().fill(Color.blue)) // Circle background
                            .overlay(Circle().stroke(Color.white, lineWidth: 2)) // White border
                        Text("Home")
                            .font(.caption) // Smaller font for tab label
                    }
                    .padding(.top, 16) // Adjust padding if needed
                }
        }
        .accentColor(.white) // Set accent color for tab items
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.6, green: 0.8, blue: 1.0), Color(red: 0.3, green: 0.6, blue: 1.0)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all) // Extend gradient background to the edges
        )
    }
}

struct Tab_View_Previews: PreviewProvider {
    static var previews: some View {
        Tab_View()
    }
}

