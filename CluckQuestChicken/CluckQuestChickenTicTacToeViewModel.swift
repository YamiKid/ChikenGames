import Foundation

enum CluckQuestChickenTicTacToeCell: String {
    case empty = ""
    case player = "❌"
    case ai = "⭕️"
}

enum CluckQuestChickenTicTacToeResult {
    case win, lose, draw, ongoing
}

class CluckQuestChickenTicTacToeViewModel {
    var CluckQuestChickenBoard: [CluckQuestChickenTicTacToeCell] = Array(repeating: .empty, count: 9)
    var CluckQuestChickenCurrentTurn: CluckQuestChickenTicTacToeCell = .player
    var CluckQuestChickenDifficulty: String = "Easy"
    var CluckQuestChickenTimer: Timer?
    var CluckQuestChickenElapsed: Int = 0
    var CluckQuestChickenOnUpdate: (() -> Void)?
    var CluckQuestChickenOnComplete: ((CluckQuestChickenTicTacToeResult) -> Void)?
    
    func CluckQuestChickenStartGame() {
        CluckQuestChickenBoard = Array(repeating: .empty, count: 9)
        CluckQuestChickenCurrentTurn = .player
        CluckQuestChickenElapsed = 0
        CluckQuestChickenTimer?.invalidate()
        CluckQuestChickenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.CluckQuestChickenElapsed += 1
            self?.CluckQuestChickenOnUpdate?()
        }
        CluckQuestChickenOnUpdate?()
    }
    
    func CluckQuestChickenMakeMove(at index: Int) {
        guard CluckQuestChickenBoard[index] == .empty, CluckQuestChickenCurrentTurn == .player else { return }
        CluckQuestChickenBoard[index] = .player
        CluckQuestChickenCurrentTurn = .ai
        CluckQuestChickenOnUpdate?()
        if let result = CluckQuestChickenCheckResult(), result != .ongoing {
            CluckQuestChickenTimer?.invalidate()
            CluckQuestChickenOnComplete?(result)
            CluckQuestChickenRecordResult(result)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.CluckQuestChickenAIMove()
        }
    }
    
    private func CluckQuestChickenAIMove() {
        let move = CluckQuestChickenBestMove()
        if move >= 0 {
            CluckQuestChickenBoard[move] = .ai
            CluckQuestChickenCurrentTurn = .player
            CluckQuestChickenOnUpdate?()
            if let result = CluckQuestChickenCheckResult(), result != .ongoing {
                CluckQuestChickenTimer?.invalidate()
                CluckQuestChickenOnComplete?(result)
                CluckQuestChickenRecordResult(result)
            }
        }
    }
    
    private func CluckQuestChickenBestMove() -> Int {
        let empty = CluckQuestChickenBoard.enumerated().filter { $0.element == .empty }.map { $0.offset }
        if CluckQuestChickenDifficulty == "Easy" {
            return empty.randomElement() ?? -1
        } else if CluckQuestChickenDifficulty == "Medium" {

            for i in empty {
                var copy = CluckQuestChickenBoard
                copy[i] = .ai
                if CluckQuestChickenCheckResult(board: copy) == .lose { return i }
            }
            for i in empty {
                var copy = CluckQuestChickenBoard
                copy[i] = .player
                if CluckQuestChickenCheckResult(board: copy) == .win { return i }
            }
            return empty.randomElement() ?? -1
        } else {

            var bestScore = -1000
            var bestMove = -1
            for i in empty {
                var copy = CluckQuestChickenBoard
                copy[i] = .ai
                let score = CluckQuestChickenMinimax(board: copy, isMax: false)
                if score > bestScore {
                    bestScore = score
                    bestMove = i
                }
            }
            return bestMove
        }
    }
    
    private func CluckQuestChickenMinimax(board: [CluckQuestChickenTicTacToeCell], isMax: Bool) -> Int {
        if let result = CluckQuestChickenCheckResult(board: board) {
            switch result {
            case .win: return -1
            case .lose: return 1
            case .draw: return 0
            case .ongoing: break
            }
        }
        let empty = board.enumerated().filter { $0.element == .empty }.map { $0.offset }
        if isMax {
            var best = -1000
            for i in empty {
                var copy = board
                copy[i] = .ai
                best = max(best, CluckQuestChickenMinimax(board: copy, isMax: false))
            }
            return best
        } else {
            var best = 1000
            for i in empty {
                var copy = board
                copy[i] = .player
                best = min(best, CluckQuestChickenMinimax(board: copy, isMax: true))
            }
            return best
        }
    }
    
    private func CluckQuestChickenCheckResult(board: [CluckQuestChickenTicTacToeCell]? = nil) -> CluckQuestChickenTicTacToeResult? {
        let b = board ?? CluckQuestChickenBoard
        let lines = [
            [0,1,2],[3,4,5],[6,7,8],
            [0,3,6],[1,4,7],[2,5,8],
            [0,4,8],[2,4,6]
        ]
        for line in lines {
            let vals = line.map { b[$0] }
            if vals.allSatisfy({ $0 == .player }) { return .win }
            if vals.allSatisfy({ $0 == .ai }) { return .lose }
        }
        if b.allSatisfy({ $0 != .empty }) { return .draw }
        return .ongoing
    }
    
    private func CluckQuestChickenRecordResult(_ result: CluckQuestChickenTicTacToeResult) {
        let key = "CluckQuestChickenTicTacToeStats_\(CluckQuestChickenDifficulty)"
        var stats = UserDefaults.standard.dictionary(forKey: key) as? [String:Int] ?? ["win":0,"lose":0,"draw":0]
        switch result {
        case .win: stats["win", default:0] += 1
        case .lose: stats["lose", default:0] += 1
        case .draw: stats["draw", default:0] += 1
        case .ongoing: break
        }
        UserDefaults.standard.set(stats, forKey: key)
        UserDefaults.standard.set("W:\(stats["win"] ?? 0) L:\(stats["lose"] ?? 0) D:\(stats["draw"] ?? 0)", forKey: "CluckQuestChickenTicTacToeBest")
    }
    
    func CluckQuestChickenXPAndCoins(result: CluckQuestChickenTicTacToeResult) -> (Int, Int) {
        switch result {
        case .win: return (50, 30)
        case .draw: return (20, 10)
        case .lose: return (10, 5)
        case .ongoing: return (0,0)
        }
    }
} 
