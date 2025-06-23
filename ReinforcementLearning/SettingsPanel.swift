//
//  SettingsPanel.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct SettingsPanel: View {
    @Binding var isVisible: Bool
    @ObservedObject var agent: QLearningAgent
    @State private var learningRate: Double
    @State private var discountFactor: Double
    @State private var epsilon: Double
    
    init(isVisible: Binding<Bool>, agent: QLearningAgent) {
        self._isVisible = isVisible
        self.agent = agent
        self._learningRate = State(initialValue: agent.learningRate)
        self._discountFactor = State(initialValue: agent.discountFactor)
        self._epsilon = State(initialValue: agent.epsilon)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background overlay
                if isVisible {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isVisible = false
                            }
                        }
                }
                
                // Settings panel
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        // Handle bar
                        RoundedRectangle(cornerRadius: 2.5)
                            .fill(Color.gray)
                            .frame(width: 40, height: 5)
                            .padding(.top, 10)
                        
                        Text("Q-Learning Parameters")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        VStack(spacing: 25) {
                            // Learning Rate (α)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Learning Rate (α)")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text(String(format: "%.2f", learningRate))
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .monospacedDigit()
                                }
                                
                                Slider(value: $learningRate, in: 0.01...0.5, step: 0.01)
                                    .accentColor(.blue)
                                    .onChange(of: learningRate) { newValue in
                                        agent.learningRate = newValue
                                    }
                            }
                            
                            // Discount Factor (γ)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Discount Factor (γ)")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text(String(format: "%.2f", discountFactor))
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .monospacedDigit()
                                }
                                
                                Slider(value: $discountFactor, in: 0.1...0.99, step: 0.01)
                                    .accentColor(.green)
                                    .onChange(of: discountFactor) { newValue in
                                        agent.discountFactor = newValue
                                    }
                            }
                            
                            // Epsilon (ε)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Exploration Rate (ε)")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text(String(format: "%.2f", epsilon))
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .monospacedDigit()
                                }
                                
                                Slider(value: $epsilon, in: 0.01...0.5, step: 0.01)
                                    .accentColor(.orange)
                                    .onChange(of: epsilon) { newValue in
                                        agent.epsilon = newValue
                                    }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Reset button
                        Button(action: resetAgent) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("Reset Training")
                            }
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.90))
                    )
                    .offset(y: isVisible ? 0 : geometry.size.height)
                }
            }
        }
        
        .animation(.easeInOut(duration: 0.3), value: isVisible)
    }
    
    private func resetAgent() {
        agent.reset()
        learningRate = agent.learningRate
        discountFactor = agent.discountFactor
        epsilon = agent.epsilon
        
        // Close the settings panel after reset
        withAnimation(.easeInOut(duration: 0.3)) {
            isVisible = false
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SettingsPanel(
            isVisible: .constant(true),
            agent: QLearningAgent(maze: MazeGrid())
        )
    }
} 
