//
//  QLearningAgent.swift
//  ReinforcementLearning
//
//  Created by Tugberk Masat on 21.06.2025.
//

import Foundation

// MARK: - Actions
enum Action: CaseIterable {
    case up, down, left, right
    
    var description: String {
        switch self {
        case .up: return "↑"
        case .down: return "↓"
        case .left: return "←"
        case .right: return "→"
        }
    }
}

// MARK: - Q-Learning Agent
class QLearningAgent: ObservableObject {
    @Published var currentPosition: Position
    @Published var episodeCount: Int = 0
    @Published var totalReward: Double = 0
    @Published var averageReward: Double = 0
    
    // Q-learning parameters
    var learningRate: Double = 0.1
    var discountFactor: Double = 0.9
    var epsilon: Double = 0.1
    
    private var qTable: [Position: [Action: Double]] = [:]
    private let maze: MazeGrid
    
    init(maze: MazeGrid, startPosition: Position = Position(row: 1, col: 1)) {
        self.maze = maze
        self.currentPosition = startPosition
        initializeQTable()
    }
    
    private func initializeQTable() {
        qTable.removeAll()
        
        // Initialize Q-values for all valid positions
        for row in 0..<maze.rows {
            for col in 0..<maze.cols {
                let position = Position(row: row, col: col)
                if maze.isValidPosition(position) {
                    qTable[position] = [:]
                    for action in Action.allCases {
                        qTable[position]?[action] = 0.0
                    }
                }
            }
        }
    }
    
    func reset() {
        currentPosition = Position(row: 1, col: 1)
        episodeCount = 0
        totalReward = 0
        averageReward = 0
        initializeQTable()
    }
    
    func getQValue(for position: Position, action: Action) -> Double {
        return qTable[position]?[action] ?? 0.0
    }
    
    func getMaxQValue(for position: Position) -> Double {
        guard let actions = qTable[position] else { return 0.0 }
        return actions.values.max() ?? 0.0
    }
    
    func getBestAction(for position: Position) -> Action {
        guard let actions = qTable[position] else { return .up }
        return actions.max(by: { $0.value < $1.value })?.key ?? .up
    }
    
    func chooseAction(for position: Position) -> Action {
        if Double.random(in: 0...1) < epsilon {
            // Exploration: random action
            return Action.allCases.randomElement() ?? .up
        } else {
            // Exploitation: best action
            return getBestAction(for: position)
        }
    }
    
    func move(from position: Position, action: Action) -> Position {
        let newRow: Int
        let newCol: Int
        
        switch action {
        case .up:
            newRow = position.row - 1
            newCol = position.col
        case .down:
            newRow = position.row + 1
            newCol = position.col
        case .left:
            newRow = position.row
            newCol = position.col - 1
        case .right:
            newRow = position.row
            newCol = position.col + 1
        }
        
        let newPosition = Position(row: newRow, col: newCol)
        return maze.isValidPosition(newPosition) ? newPosition : position
    }
    
    func getReward(for position: Position) -> Double {
        let cellType = maze.getCellType(at: position)
        switch cellType {
        case .goal:
            return 100.0
        case .wall:
            return -10.0
        case .path:
            return -0.1
        }
    }
    
    func updateQValue(for position: Position, action: Action, newPosition: Position, reward: Double) {
        let currentQ = getQValue(for: position, action: action)
        let maxNextQ = getMaxQValue(for: newPosition)
        
        let newQ = currentQ + learningRate * (reward + discountFactor * maxNextQ - currentQ)
        qTable[position]?[action] = newQ
    }
    
    func step() -> Bool {
        let action = chooseAction(for: currentPosition)
        let newPosition = move(from: currentPosition, action: action)
        let reward = getReward(for: newPosition)
        
        updateQValue(for: currentPosition, action: action, newPosition: newPosition, reward: reward)
        
        currentPosition = newPosition
        totalReward += reward
        
        // Check if episode is complete (reached goal)
        if maze.getCellType(at: currentPosition) == .goal {
            episodeCount += 1
            averageReward = totalReward / Double(episodeCount)
            currentPosition = Position(row: 1, col: 1) // Reset to start
            return true
        }
        
        return false
    }
} 