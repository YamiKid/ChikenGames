import UIKit
import SpriteKit

struct CluckQuestChickenPuzzleAssemblyConfig {
    let CluckQuestChickenImageName: String
    let CluckQuestChickenGridSize: Int
}

class CluckQuestChickenPuzzleAssemblyViewModel {
    let CluckQuestChickenImages = ["CluckQuestChickenImg1", "CluckQuestChickenImg2", "CluckQuestChickenImg3"]
    let CluckQuestChickenDifficulties = ["Easy": 3, "Medium": 4, "Hard": 5]
    var CluckQuestChickenSelectedImage: String = "CluckQuestChickenImg1"
    var CluckQuestChickenSelectedDifficulty: String = "Easy"
    var CluckQuestChickenGridSize: Int { CluckQuestChickenDifficulties[CluckQuestChickenSelectedDifficulty] ?? 3 }
    var CluckQuestChickenTimer: Timer?
    var CluckQuestChickenElapsed: Int = 0
    var CluckQuestChickenMoves: Int = 0
    var CluckQuestChickenIsPaused = false
    var CluckQuestChickenOnUpdate: (() -> Void)?
    var CluckQuestChickenOnComplete: ((Int, Int) -> Void)?
    
    func CluckQuestChickenStartTimer() {
        CluckQuestChickenTimer?.invalidate()
        CluckQuestChickenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, !self.CluckQuestChickenIsPaused else { return }
            self.CluckQuestChickenElapsed += 1
            self.CluckQuestChickenOnUpdate?()
        }
    }
    
    func CluckQuestChickenPause() {
        CluckQuestChickenIsPaused = true
    }
    
    func CluckQuestChickenResume() {
        CluckQuestChickenIsPaused = false
    }
    
    func CluckQuestChickenStopTimer() {
        CluckQuestChickenTimer?.invalidate()
    }
    
    func CluckQuestChickenRecordBestIfNeeded() {
        let key = "CluckQuestChickenPuzzleBest_\(CluckQuestChickenSelectedImage)_\(CluckQuestChickenSelectedDifficulty)"
        let prev = UserDefaults.standard.string(forKey: key)
        let newVal = "\(CluckQuestChickenElapsed)s, \(CluckQuestChickenMoves) moves"
        if prev == nil || CluckQuestChickenElapsed < (Int(prev?.split(separator: "s").first ?? "9999") ?? 9999) {
            UserDefaults.standard.set(newVal, forKey: key)
            UserDefaults.standard.set(newVal, forKey: "CluckQuestChickenPuzzleBest")
        }
    }
    
    func CluckQuestChickenXPAndCoins() -> (Int, Int) {
        let baseXP = 20 * CluckQuestChickenGridSize
        let baseCoins = 10 * CluckQuestChickenGridSize
        let bonus = max(0, 100 - CluckQuestChickenElapsed - CluckQuestChickenMoves)
        return (baseXP + bonus, baseCoins + bonus/2)
    }
} 