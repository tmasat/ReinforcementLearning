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
    
    init(maze: MazeGrid, cellSize: CGFloat = 30) {
        self.maze = maze
        self.cellSize = cellSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<maze.rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<maze.cols, id: \.self) { col in
                        let cellType = maze.grid[row][col]
                        
                        Rectangle()
                            .fill(cellType.color)
                            .frame(width: cellSize, height: cellSize)
                            .border(Color.white.opacity(0.1), width: 0.5)
                    }
                }
            }
        }
        .background(Color.black)
    }
}

#Preview {
    MazeGridView(maze: MazeGrid())
        .background(Color.black)
} 