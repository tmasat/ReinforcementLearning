//
//  MetricsHUD.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct MetricsHUD: View {
    @ObservedObject var agent: QLearningAgent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundStyle(.white)
                Text("Live Metrics")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            // Metrics grid
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                MetricCard(
                    title: "Episodes",
                    value: "\(agent.episodeCount)",
                    icon: "number.circle.fill",
                    color: .blue
                )
                
                MetricCard(
                    title: "Steps",
                    value: "\(agent.stepsInCurrentEpisode)",
                    icon: "figure.walk",
                    color: .green
                )
                
                MetricCard(
                    title: "Total Reward",
                    value: String(format: "%.1f", agent.totalReward),
                    icon: "star.fill",
                    color: .yellow
                )
                
                MetricCard(
                    title: "Avg Reward",
                    value: String(format: "%.2f", agent.averageReward),
                    icon: "chart.bar.fill",
                    color: .orange
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
        .padding()
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.caption)
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                
                Spacer()
            }
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .monospacedDigit()
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.1))
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        MetricsHUD(agent: QLearningAgent(maze: MazeGrid()))
    }
} 