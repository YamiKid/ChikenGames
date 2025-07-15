import Foundation

struct CluckQuestChickenFarmSweeperCell {
    var CluckQuestChickenIsMine: Bool
    var CluckQuestChickenIsRevealed: Bool
    var CluckQuestChickenIsFlagged: Bool
    var CluckQuestChickenNeighborMines: Int
}

class CluckQuestChickenFarmSweeperViewModel {
    let CluckQuestChickenDifficulties = ["Easy": (5,5,10), "Medium": (7,7,25), "Hard": (9,9,35)]
    var CluckQuestChickenSelectedDifficulty: String = "Easy"
    var CluckQuestChickenRows: Int { CluckQuestChickenFarmSweeperViewModel.CluckQuestChickenDifficulties[CluckQuestChickenSelectedDifficulty]?.0 ?? 5 }
    var CluckQuestChickenCols: Int { CluckQuestChickenFarmSweeperViewModel.CluckQuestChickenDifficulties[CluckQuestChickenSelectedDifficulty]?.1 ?? 5 }
    var CluckQuestChickenMines: Int { CluckQuestChickenFarmSweeperViewModel.CluckQuestChickenDifficulties[CluckQuestChickenSelectedDifficulty]?.2 ?? 10 }
    var CluckQuestChickenBoard: [[CluckQuestChickenFarmSweeperCell]] = []
    var CluckQuestChickenTimer: Timer?
    var CluckQuestChickenElapsed: Int = 0
    var CluckQuestChickenFlags: Int = 0
    var CluckQuestChickenGameOver: Bool = false
    var CluckQuestChickenOnUpdate: (() -> Void)?
    var CluckQuestChickenOnComplete: ((Bool) -> Void)?
    var CluckQuestChickenFirstClick: Bool = true
    
    static let CluckQuestChickenDifficulties = ["Easy": (5,5,10), "Medium": (7,7,25), "Hard": (9,9,35)]
    
    func CluckQuestChickenStartGame() {
        CluckQuestChickenBoard = Array(repeating: Array(repeating: CluckQuestChickenFarmSweeperCell(CluckQuestChickenIsMine: false, CluckQuestChickenIsRevealed: false, CluckQuestChickenIsFlagged: false, CluckQuestChickenNeighborMines: 0), count: CluckQuestChickenCols), count: CluckQuestChickenRows)
        var mines = Set<Int>()
        while mines.count < CluckQuestChickenMines {
            let idx = Int.random(in: 0..<(CluckQuestChickenRows*CluckQuestChickenCols))
            mines.insert(idx)
        }
        for idx in mines {
            let r = idx / CluckQuestChickenCols
            let c = idx % CluckQuestChickenCols
            CluckQuestChickenBoard[r][c].CluckQuestChickenIsMine = true
        }
        for r in 0..<CluckQuestChickenRows {
            for c in 0..<CluckQuestChickenCols {
                CluckQuestChickenBoard[r][c].CluckQuestChickenNeighborMines = CluckQuestChickenCountNeighborMines(r: r, c: c)
            }
        }
        CluckQuestChickenElapsed = 0
        CluckQuestChickenFlags = 0
        CluckQuestChickenGameOver = false
        CluckQuestChickenFirstClick = true
        CluckQuestChickenTimer?.invalidate()
        CluckQuestChickenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.CluckQuestChickenElapsed += 1
            self?.CluckQuestChickenOnUpdate?()
        }
        CluckQuestChickenOnUpdate?()
    }
    
    func CluckQuestChickenReveal(r: Int, c: Int) {
        guard !CluckQuestChickenGameOver, r >= 0, c >= 0, r < CluckQuestChickenRows, c < CluckQuestChickenCols else { return }
        if CluckQuestChickenFirstClick {
            CluckQuestChickenFirstClick = false

            var safeCells: [(Int, Int)] = []
            for dr in -1...1 {
                for dc in -1...1 {
                    let nr = r+dr, nc = c+dc
                    if nr >= 0, nc >= 0, nr < CluckQuestChickenRows, nc < CluckQuestChickenCols {
                        safeCells.append((nr, nc))
                    }
                }
            }

            var minePositions: [(Int, Int)] = []
            for (i, row) in CluckQuestChickenBoard.enumerated() {
                for (j, cell) in row.enumerated() {
                    if cell.CluckQuestChickenIsMine { minePositions.append((i, j)) }
                }
            }
            var toMove: [(Int, Int)] = []
            for pos in minePositions {
                if safeCells.contains(where: { $0 == pos }) {
                    toMove.append(pos)
                }
            }
            var emptyCells: [(Int, Int)] = []
            for i in 0..<CluckQuestChickenRows {
                for j in 0..<CluckQuestChickenCols {
                    if !CluckQuestChickenBoard[i][j].CluckQuestChickenIsMine && !safeCells.contains(where: { $0 == (i, j) }) {
                        emptyCells.append((i, j))
                    }
                }
            }
            emptyCells.shuffle()
            for (idx, from) in toMove.enumerated() {
                if idx < emptyCells.count {
                    let to = emptyCells[idx]
                    CluckQuestChickenBoard[from.0][from.1].CluckQuestChickenIsMine = false
                    CluckQuestChickenBoard[to.0][to.1].CluckQuestChickenIsMine = true
                }
            }

            for i in 0..<CluckQuestChickenRows {
                for j in 0..<CluckQuestChickenCols {
                    CluckQuestChickenBoard[i][j].CluckQuestChickenNeighborMines = CluckQuestChickenCountNeighborMines(r: i, c: j)
                }
            }

            for (nr, nc) in safeCells {
                if !CluckQuestChickenBoard[nr][nc].CluckQuestChickenIsRevealed {
                    CluckQuestChickenBoard[nr][nc].CluckQuestChickenIsRevealed = true
                }
            }
            if CluckQuestChickenCheckWin() {
                CluckQuestChickenGameOver = true
                CluckQuestChickenTimer?.invalidate()
                CluckQuestChickenOnComplete?(true)
            }
            CluckQuestChickenOnUpdate?()
            return
        }
        let cell = CluckQuestChickenBoard[r][c]
        if cell.CluckQuestChickenIsRevealed || cell.CluckQuestChickenIsFlagged { return }
        CluckQuestChickenBoard[r][c].CluckQuestChickenIsRevealed = true
        if cell.CluckQuestChickenIsMine {
            CluckQuestChickenGameOver = true
            CluckQuestChickenTimer?.invalidate()
            CluckQuestChickenOnComplete?(false)
            return
        }
        if cell.CluckQuestChickenNeighborMines == 0 {
            for dr in -1...1 {
                for dc in -1...1 {
                    if dr != 0 || dc != 0 {
                        CluckQuestChickenReveal(r: r+dr, c: c+dc)
                    }
                }
            }
        }
        if CluckQuestChickenCheckWin() {
            CluckQuestChickenGameOver = true
            CluckQuestChickenTimer?.invalidate()
            CluckQuestChickenOnComplete?(true)
        }
        CluckQuestChickenOnUpdate?()
    }
    
    func CluckQuestChickenFlag(r: Int, c: Int) {
        guard !CluckQuestChickenGameOver, r >= 0, c >= 0, r < CluckQuestChickenRows, c < CluckQuestChickenCols else { return }
        if CluckQuestChickenBoard[r][c].CluckQuestChickenIsRevealed { return }
        CluckQuestChickenBoard[r][c].CluckQuestChickenIsFlagged.toggle()
        CluckQuestChickenFlags += CluckQuestChickenBoard[r][c].CluckQuestChickenIsFlagged ? 1 : -1
        CluckQuestChickenOnUpdate?()
    }
    
    private func CluckQuestChickenCountNeighborMines(r: Int, c: Int) -> Int {
        var count = 0
        for dr in -1...1 {
            for dc in -1...1 {
                let nr = r+dr, nc = c+dc
                if nr >= 0, nc >= 0, nr < CluckQuestChickenRows, nc < CluckQuestChickenCols, (dr != 0 || dc != 0) {
                    if CluckQuestChickenBoard[nr][nc].CluckQuestChickenIsMine { count += 1 }
                }
            }
        }
        return count
    }
    
    private func CluckQuestChickenCheckWin() -> Bool {
        for r in 0..<CluckQuestChickenRows {
            for c in 0..<CluckQuestChickenCols {
                let cell = CluckQuestChickenBoard[r][c]
                if !cell.CluckQuestChickenIsMine && !cell.CluckQuestChickenIsRevealed { return false }
            }
        }
        return true
    }
    
    func CluckQuestChickenRecordBestIfNeeded() {
        let key = "CluckQuestChickenSweeperBest_\(CluckQuestChickenSelectedDifficulty)"
        let prev = UserDefaults.standard.string(forKey: key)
        let newVal = "\(CluckQuestChickenElapsed)s"
        if prev == nil || CluckQuestChickenElapsed < (Int(prev?.split(separator: "s").first ?? "9999") ?? 9999) {
            UserDefaults.standard.set(newVal, forKey: key)
            UserDefaults.standard.set(newVal, forKey: "CluckQuestChickenSweeperBest")
        }
    }
    
    func CluckQuestChickenXPAndCoins(win: Bool) -> (Int, Int) {
        if win {
            let baseXP = 50 * CluckQuestChickenRows
            let baseCoins = 20 * CluckQuestChickenRows
            let bonus = max(0, 100 - CluckQuestChickenElapsed)
            return (baseXP + bonus, baseCoins + bonus/2)
        } else {
            return (5, 2)
        }
    }
} 
