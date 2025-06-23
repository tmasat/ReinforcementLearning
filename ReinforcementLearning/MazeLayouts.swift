//
//  MazeLayouts.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import Foundation

// MARK: - Maze Layouts
struct MazeLayouts {
    
    // MARK: - Maze 1: Spiral Pattern (11x11)
    static let maze1: [[Int]] = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
    
    // MARK: - Maze 2: Branching Corridors (11x11)
    static let maze2: [[Int]] = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
    
    // MARK: - Maze 3: Zigzag Pattern (11x11)
    static let maze3: [[Int]] = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
    
    // MARK: - Get Random Maze
    static func getRandomMaze() -> [[Int]] {
        let mazes = [maze1, maze2, maze3]
        return mazes.randomElement() ?? maze1
    }
    
    // MARK: - Get Maze Info
    static func getMazeInfo(for maze: [[Int]]) -> (rows: Int, cols: Int, startPosition: Position, goalPosition: Position) {
        let rows = maze.count
        let cols = maze[0].count
        
        // Find start position (top-left path)
        let startPosition = Position(row: 1, col: 1)
        
        // Find goal position
        var goalPosition = Position(row: rows - 2, col: cols - 2)
        for row in 0..<rows {
            for col in 0..<cols {
                if maze[row][col] == 2 {
                    goalPosition = Position(row: row, col: col)
                    break
                }
            }
        }
        
        return (rows, cols, startPosition, goalPosition)
    }
} 
