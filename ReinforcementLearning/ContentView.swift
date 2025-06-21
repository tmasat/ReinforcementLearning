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
    @State private var showSettings = false
    
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
                HStack {
                    Text("Q-Learning Maze Solver")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    // Settings button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showSettings.toggle()
                        }
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
                // Enhanced stats display
                VStack(spacing: 8) {
                    HStack {
                        Text("Episodes: \(agent.episodeCount)")
                            .foregroundStyle(.white)
                            .font(.caption)
                        
                        Spacer()
                        
                        Text("Total Reward: \(String(format: "%.1f", agent.totalReward))")
                            .foregroundStyle(.white)
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Avg Reward: \(String(format: "%.2f", agent.averageReward))")
                            .foregroundStyle(.white)
                            .font(.caption)
                        
                        Spacer()
                        
                        Text("ε: \(String(format: "%.2f", agent.epsilon))")
                            .foregroundStyle(.white)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                MazeGridView(maze: maze, cellSize: 25, agentPosition: agent.currentPosition, agent: agent)
                    .padding()
                
                Spacer()
                
                // Control button
                Button(action: toggleSimulation) {
                    Text(isRunning ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 200) // Sabit genişlik
                        .background(isRunning ? Color.red : Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            
            // Settings panel
            SettingsPanel(isVisible: $showSettings, agent: agent)
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
