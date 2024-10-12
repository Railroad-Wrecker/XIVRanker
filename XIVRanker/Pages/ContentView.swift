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

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.0, green: 0.0, blue: 0.5)
                .edgesIgnoringSafeArea(.all)
            
            // Yellow Circle
            Circle()
                .fill(Color.yellow)
                .frame(width: 200, height: 200)
                .position(x: 400, y: 100)
            
            // Red Rectangle
            Image("RMIT_Pixel")
                .resizable()
                .frame(width: 500, height: 500)
                .position(x: 230, y: 770)
            
            VStack {
                Spacer()
                
                Image("FFXIV_Ranker_Logo")
                    .resizable()
                    .frame(width: 300, height: 150)
                    .padding()
                    .position(x: 180 ,y: 300)
                
                Button(action: {
                    // Navigate to the navigation list view
                }) {
                    Text("Start Ranking")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .position(x: 180, y:280)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

