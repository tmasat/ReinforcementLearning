//
//  MazeGrid.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import Foundation
import SwiftUI

// MARK: - Cell Types
enum CellType: CaseIterable {
    case wall
    case path
    case goal
    
    var color: Color {
        switch self {
        case .wall:
            return Color.gray
        case .path:
            return Color.black
        case .goal:
            return Color.green
        }
    }
}

// MARK: - Position
struct Position: Hashable, Equatable {
    let row: Int
    let col: Int
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
}

// MARK: - Maze Grid
struct MazeGrid {
    let rows: Int
    let cols: Int
    private(set) var grid: [[CellType]]
    
    init(rows: Int = 10, cols: Int = 10) {
        self.rows = rows
        self.cols = cols
        self.grid = Array(repeating: Array(repeating: .path, count: cols), count: rows)
        
        // Create a simple maze pattern
        createMaze()
    }
    
    private mutating func createMaze() {
        // Add walls around the perimeter
        for row in 0..<rows {
            for col in 0..<cols {
                if row == 0 || row == rows - 1 || col == 0 || col == cols - 1 {
                    grid[row][col] = .wall
                }
            }
        }
        
        // Add some internal walls
        let wallPositions = [
            (2, 2), (2, 3), (2, 4), (2, 5),
            (4, 1), (4, 2), (4, 3), (4, 4),
            (6, 5), (6, 6), (6, 7), (6, 8),
            (8, 2), (8, 3), (8, 4), (8, 5)
        ]
        
        for (row, col) in wallPositions {
            if row < rows && col < cols {
                grid[row][col] = .wall
            }
        }
        
        // Set goal position
        grid[rows - 2][cols - 2] = .goal
    }
    
    func getCellType(at position: Position) -> CellType {
        guard position.row >= 0 && position.row < rows &&
              position.col >= 0 && position.col < cols else {
            return .wall
        }
        return grid[position.row][position.col]
    }
    
    func isValidPosition(_ position: Position) -> Bool {
        return position.row >= 0 && position.row < rows &&
               position.col >= 0 && position.col < cols &&
               grid[position.row][position.col] != .wall
    }
    
    func getGoalPosition() -> Position {
        for row in 0..<rows {
            for col in 0..<cols {
                if grid[row][col] == .goal {
                    return Position(row: row, col: col)
                }
            }
        }
        return Position(row: rows - 2, col: cols - 2)
    }
} 