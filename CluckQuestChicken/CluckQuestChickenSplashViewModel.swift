import UIKit

class CluckQuestChickenSplashViewModel {
    let CluckQuestChickenSplashDuration: TimeInterval = 1.7
    let CluckQuestChickenEmojis = ["🐔", "🌾", "🍃", "🐛"]
    var CluckQuestChickenOnFinish: (() -> Void)?
    
    func CluckQuestChickenStartSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + CluckQuestChickenSplashDuration) { [weak self] in
            self?.CluckQuestChickenOnFinish?()
        }
    }
} 