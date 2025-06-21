//
//  ContentView.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var maze = MazeGrid()
    
    var body: some View {
        ZStack {
            // Full-screen background
            Color.black
                .ignoresSafeArea()
            
            // Maze grid
            VStack {
                Text("Q-Learning Maze Solver")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top)
                
                Spacer()
                
                MazeGridView(maze: maze, cellSize: 25)
                    .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
