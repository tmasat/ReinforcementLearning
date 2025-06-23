//
//  ContentView.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//
// Note: For haptic feedback to work, add this key to Info.plist:
// NSHapticsUsageDescription = "This app uses haptic feedback to provide tactile response when the agent reaches the goal."

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
            Color(.systemBackground)
                .ignoresSafeArea()
            
            // Maze grid with agent
            VStack {
                HStack {
                    Text("Q-Learning Maze Solver")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.label))
                    
                    Spacer()
                    
                    // Settings button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showSettings.toggle()
                        }
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundStyle(Color(.label))
                            .padding(8)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }
                }
                .padding(.top)
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
                        .background(isRunning ? Color(.systemRed) : Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            
            // Metrics HUD
            VStack {
                HStack {
                    MetricsHUD(agent: agent)
                    Spacer()
                }
                Spacer()
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
