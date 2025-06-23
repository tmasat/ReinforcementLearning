//
//  MazeGridView.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct MazeGridView: View {
    let cellSize: CGFloat
    @ObservedObject var agent: QLearningAgent
    
    init(cellSize: CGFloat = 30, agent: QLearningAgent) {
        self.cellSize = cellSize
        self.agent = agent
    }
    
    var body: some View {
        VStack(spacing: 0) {
            let maze = agent.getMaze()
            ForEach(0..<maze.rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<maze.cols, id: \.self) { col in
                        let cellType = maze.grid[row][col]
                        let position = Position(row: row, col: col)
                        let isAgentHere = agent.currentPosition == position
                        let trailIndex = getTrailIndex(for: position)
                        
                        ZStack {
                            Rectangle()
                                .fill(cellType.color)
                                .frame(width: cellSize, height: cellSize)
                                .border(Color(.systemGray5), width: 0.5)
                            
                            // Q-value heatmap overlay
                            if maze.isValidPosition(position) && cellType != .goal {
                                let maxQValue = agent.getMaxQValue(for: position)
                                let heatmapColor = getHeatmapColor(for: maxQValue)
                                
                                Rectangle()
                                    .fill(heatmapColor)
                                    .frame(width: cellSize, height: cellSize)
                                    .opacity(0.4)
                            }
                            
                            // Path trail
                            if let trailIndex = trailIndex {
                                Circle()
                                    .fill(Color(.systemYellow))
                                    .frame(width: cellSize * 0.3, height: cellSize * 0.3)
                                    .opacity(0.3 + (0.4 * Double(trailIndex) / 50.0))
                            }
                            
                            // Agent visualization
                            if isAgentHere {
                                Circle()
                                    .fill(Color(.systemRed))
                                    .frame(width: cellSize * 0.6, height: cellSize * 0.6)
                                    .shadow(color: Color(.systemRed).opacity(0.5), radius: 4)
                                    .scaleEffect(1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: agent.currentPosition)
                            }
                        }
                    }
                }
            }
        }
        .background(Color(.systemBackground))
    }
    
    private func getHeatmapColor(for qValue: Double) -> Color {
        // Normalize Q-value to 0-1 range (assuming max Q-value around 100)
        let normalized = min(max(qValue / 100.0, 0.0), 1.0)
        
        // Create a gradient from blue (low values) to red (high values)
        if normalized < 0.5 {
            // Blue to green
            let t = normalized * 2.0
            return Color(red: 0.0, green: t, blue: 1.0 - t)
        } else {
            // Green to red
            let t = (normalized - 0.5) * 2.0
            return Color(red: t, green: 1.0 - t, blue: 0.0)
        }
    }
    
    private func getTrailIndex(for position: Position) -> Int? {
        return agent.pathHistory.firstIndex(of: position)
    }
}

#Preview {
    MazeGridView(agent: QLearningAgent())
        .background(Color(.systemBackground))
} 
