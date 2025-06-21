//
//  ContentView.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Full-screen background
            Color.black
                .ignoresSafeArea()
            
            // Placeholder content
            VStack {
                Image(systemName: "brain.head.profile")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .font(.system(size: 60))
                
                Text("Q-Learning Maze Solver")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Coming soon...")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
