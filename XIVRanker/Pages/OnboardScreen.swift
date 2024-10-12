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

struct OnboardScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        NavigationStack {
            if isActive {
                WelcomeScreen()
            } else {
                ZStack {
                    Color(red: 0.0, green: 0.0, blue: 0.5)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        
                        VStack {
                            Image("FFXIV_Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isActive = true
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

struct OnboardScreen_Preview: PreviewProvider {
    static var previews: some View {
        OnboardScreen()
    }
}

