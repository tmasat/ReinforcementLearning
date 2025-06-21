//
//  ContentView.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var maze = MazeGrid()
    @State private var agent: QLearningAgent
    @State private var timer: Timer?
    @State private var isRunning = false
    
    init() {
        let maze = MazeGrid()
        self._maze = State(initialValue: maze)
        self._agent = State(initialValue: QLearningAgent(maze: maze))
    }
    
    var body: some View {
        ZStack {
            // Full-screen background
            Color.black
                .ignoresSafeArea()
            
            // Maze grid with agent
            VStack {
                Text("Q-Learning Maze Solver")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top)
                
                // Stats display
                HStack {
                    Text("Episodes: \(agent.episodeCount)")
                        .foregroundStyle(.white)
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("Reward: \(String(format: "%.1f", agent.totalReward))")
                        .foregroundStyle(.white)
                        .font(.caption)
                }
                .padding(.horizontal)
                
                Spacer()
                
                MazeGridView(maze: maze, cellSize: 25, agentPosition: agent.currentPosition)
                    .padding()
                
                Spacer()
                
                // Control button
                Button(action: toggleSimulation) {
                    Text(isRunning ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(isRunning ? Color.red : Color.green)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
        }
        .onDisappear {
            stopSimulation()
        }
    }
    
    private func toggleSimulation() {
        if isRunning {
            stopSimulation()
        } else {
            startSimulation()
        }
    }
    
    private func startSimulation() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            agent.step()
        }
    }
    
    private func stopSimulation() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ContentView()
}
