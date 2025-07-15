import UIKit

struct CluckQuestChickenOnboardingPage {
    let CluckQuestChickenTitle: String
    let CluckQuestChickenBody: String
    let CluckQuestChickenEmojis: String
}

class CluckQuestChickenOnboardingViewModel {
    let CluckQuestChickenPages: [CluckQuestChickenOnboardingPage] = [
        CluckQuestChickenOnboardingPage(
            CluckQuestChickenTitle: "Welcome, Farmer!",
            CluckQuestChickenBody: "Meet Clucky, your unstoppable coop explorer. Tap to uncover hidden barns.",
            CluckQuestChickenEmojis: "🐔🌾"
        ),
        CluckQuestChickenOnboardingPage(
            CluckQuestChickenTitle: "Explore the Barnyard",
            CluckQuestChickenBody: "Wander fields, orchards & ponds. Discover secret pathways and treasures.",
            CluckQuestChickenEmojis: "🌱🍏🦆"
        ),
        CluckQuestChickenOnboardingPage(
            CluckQuestChickenTitle: "Play Fun Mini-Games",
            CluckQuestChickenBody: "Catch mealworms, tilt for grain, flip cards in relaxing SpriteKit scenes.",
            CluckQuestChickenEmojis: "🐛🌾🃏"
        ),
        CluckQuestChickenOnboardingPage(
            CluckQuestChickenTitle: "Solve Farm Puzzles",
            CluckQuestChickenBody: "Slide hay-bales, assemble jigsaws & crack coop-lock codes.",
            CluckQuestChickenEmojis: "🧩🚜🔐"
        ),
        CluckQuestChickenOnboardingPage(
            CluckQuestChickenTitle: "Build Your Empire",
            CluckQuestChickenBody: "Earn CluckCoins & XP. Upgrade tools, outfits & expand your feathered realm.",
            CluckQuestChickenEmojis: "💰👒🏰"
        )
    ]
    
    var CluckQuestChickenCurrentPage = 0
    var CluckQuestChickenOnFinish: (() -> Void)?
    
    func CluckQuestChickenAdvancePage() {
        if CluckQuestChickenCurrentPage < CluckQuestChickenPages.count - 1 {
            CluckQuestChickenCurrentPage += 1
        } else {
            UserDefaults.standard.set(true, forKey: "CluckQuestChickenHasOnboarded")
            CluckQuestChickenOnFinish?()
        }
    }
} 