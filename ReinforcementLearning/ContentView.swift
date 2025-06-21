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
            VStack(spacing: 20) {
                Image(systemName: "brain.head.profile")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .font(.system(size: 80))
                
                Text("Q-Learning Maze Solver")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Coming soon...")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
