//
//  MazeGridView.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import SwiftUI

struct MazeGridView: View {
    let maze: MazeGrid
    let cellSize: CGFloat
    let agentPosition: Position?
    let agent: QLearningAgent?
    
    init(maze: MazeGrid, cellSize: CGFloat = 30, agentPosition: Position? = nil, agent: QLearningAgent? = nil) {
        self.maze = maze
        self.cellSize = cellSize
        self.agentPosition = agentPosition
        self.agent = agent
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<maze.rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<maze.cols, id: \.self) { col in
                        let cellType = maze.grid[row][col]
                        let position = Position(row: row, col: col)
                        let isAgentHere = agentPosition == position
                        
                        ZStack {
                            Rectangle()
                                .fill(cellType.color)
                                .frame(width: cellSize, height: cellSize)
                                .border(Color.white.opacity(0.1), width: 0.5)
                            
                            // Q-value heatmap overlay
                            if let agent = agent, maze.isValidPosition(position) && cellType != .goal {
                                let maxQValue = agent.getMaxQValue(for: position)
                                let heatmapColor = getHeatmapColor(for: maxQValue)
                                
                                Rectangle()
                                    .fill(heatmapColor)
                                    .frame(width: cellSize, height: cellSize)
                                    .opacity(0.3)
                            }
                            
                            // Agent visualization
                            if isAgentHere {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: cellSize * 0.6, height: cellSize * 0.6)
                                    .shadow(color: .red.opacity(0.5), radius: 4)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.black)
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
}

#Preview {
    MazeGridView(maze: MazeGrid(), agentPosition: Position(row: 1, col: 1))
        .background(Color.black)
} 