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
    
    init(maze: MazeGrid, cellSize: CGFloat = 30, agentPosition: Position? = nil) {
        self.maze = maze
        self.cellSize = cellSize
        self.agentPosition = agentPosition
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
}

#Preview {
    MazeGridView(maze: MazeGrid(), agentPosition: Position(row: 1, col: 1))
        .background(Color.black)
} 