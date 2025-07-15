import Foundation

class CluckQuestChickenDataManager {
    static let shared = CluckQuestChickenDataManager()
    
    private let CluckQuestChickenUserDefaults = UserDefaults.standard
    private let CluckQuestChickenPlayerDataKey = "CluckQuestChickenPlayerData"
    private let CluckQuestChickenQuestsKey = "CluckQuestChickenQuests"
    private let CluckQuestChickenAchievementsKey = "CluckQuestChickenAchievements"
    private let CluckQuestChickenFactsKey = "CluckQuestChickenFacts"
    private let CluckQuestChickenMiniGamesKey = "CluckQuestChickenMiniGames"
    private let CluckQuestChickenAreasKey = "CluckQuestChickenAreas"
    
    private init() {
        CluckQuestChickenInitializeData()
    }
    
    private func CluckQuestChickenInitializeData() {
        if CluckQuestChickenUserDefaults.object(forKey: CluckQuestChickenPlayerDataKey) == nil {
            CluckQuestChickenSavePlayerData(CluckQuestChickenPlayerData())
        }
        
        if CluckQuestChickenUserDefaults.object(forKey: CluckQuestChickenQuestsKey) == nil {
            CluckQuestChickenSaveQuests(CluckQuestChickenCreateDefaultQuests())
        }
        
        if CluckQuestChickenUserDefaults.object(forKey: CluckQuestChickenAchievementsKey) == nil {
            CluckQuestChickenSaveAchievements(CluckQuestChickenCreateDefaultAchievements())
        }
        
        if CluckQuestChickenUserDefaults.object(forKey: CluckQuestChickenFactsKey) == nil {
            CluckQuestChickenSaveFacts(CluckQuestChickenCreateDefaultFacts())
        }
        
        if CluckQuestChickenUserDefaults.object(forKey: CluckQuestChickenMiniGamesKey) == nil {
            CluckQuestChickenSaveMiniGames(CluckQuestChickenCreateDefaultMiniGames())
        }
        
        if CluckQuestChickenUserDefaults.object(forKey: CluckQuestChickenAreasKey) == nil {
            CluckQuestChickenSaveAreas(CluckQuestChickenCreateDefaultAreas())
        }
    }
    
    func CluckQuestChickenLoadPlayerData() -> CluckQuestChickenPlayerData {
        guard let CluckQuestChickenData = CluckQuestChickenUserDefaults.data(forKey: CluckQuestChickenPlayerDataKey),
              let CluckQuestChickenPlayerData = try? JSONDecoder().decode(CluckQuestChickenPlayerData.self, from: CluckQuestChickenData) else {
            return CluckQuestChickenPlayerData()
        }
        return CluckQuestChickenPlayerData
    }
    
    func CluckQuestChickenSavePlayerData(_ CluckQuestChickenPlayerData: CluckQuestChickenPlayerData) {
        if let CluckQuestChickenEncodedData = try? JSONEncoder().encode(CluckQuestChickenPlayerData) {
            CluckQuestChickenUserDefaults.set(CluckQuestChickenEncodedData, forKey: CluckQuestChickenPlayerDataKey)
        }
    }
    
    func CluckQuestChickenLoadQuests() -> [CluckQuestChickenQuest] {
        guard let CluckQuestChickenData = CluckQuestChickenUserDefaults.data(forKey: CluckQuestChickenQuestsKey),
              let CluckQuestChickenQuests = try? JSONDecoder().decode([CluckQuestChickenQuest].self, from: CluckQuestChickenData) else {
            return CluckQuestChickenCreateDefaultQuests()
        }
        return CluckQuestChickenQuests
    }
    
    func CluckQuestChickenSaveQuests(_ CluckQuestChickenQuests: [CluckQuestChickenQuest]) {
        if let CluckQuestChickenEncodedData = try? JSONEncoder().encode(CluckQuestChickenQuests) {
            CluckQuestChickenUserDefaults.set(CluckQuestChickenEncodedData, forKey: CluckQuestChickenQuestsKey)
        }
    }
    
    func CluckQuestChickenLoadAchievements() -> [CluckQuestChickenAchievement] {
        guard let CluckQuestChickenData = CluckQuestChickenUserDefaults.data(forKey: CluckQuestChickenAchievementsKey),
              let CluckQuestChickenAchievements = try? JSONDecoder().decode([CluckQuestChickenAchievement].self, from: CluckQuestChickenData) else {
            return CluckQuestChickenCreateDefaultAchievements()
        }
        return CluckQuestChickenAchievements
    }
    
    func CluckQuestChickenSaveAchievements(_ CluckQuestChickenAchievements: [CluckQuestChickenAchievement]) {
        if let CluckQuestChickenEncodedData = try? JSONEncoder().encode(CluckQuestChickenAchievements) {
            CluckQuestChickenUserDefaults.set(CluckQuestChickenEncodedData, forKey: CluckQuestChickenAchievementsKey)
        }
    }
    
    func CluckQuestChickenLoadFacts() -> [CluckQuestChickenFarmFact] {
        guard let CluckQuestChickenData = CluckQuestChickenUserDefaults.data(forKey: CluckQuestChickenFactsKey),
              let CluckQuestChickenFacts = try? JSONDecoder().decode([CluckQuestChickenFarmFact].self, from: CluckQuestChickenData) else {
            return CluckQuestChickenCreateDefaultFacts()
        }
        return CluckQuestChickenFacts
    }
    
    func CluckQuestChickenSaveFacts(_ CluckQuestChickenFacts: [CluckQuestChickenFarmFact]) {
        if let CluckQuestChickenEncodedData = try? JSONEncoder().encode(CluckQuestChickenFacts) {
            CluckQuestChickenUserDefaults.set(CluckQuestChickenEncodedData, forKey: CluckQuestChickenFactsKey)
        }
    }
    
    func CluckQuestChickenLoadMiniGames() -> [CluckQuestChickenMiniGame] {
        guard let CluckQuestChickenData = CluckQuestChickenUserDefaults.data(forKey: CluckQuestChickenMiniGamesKey),
              let CluckQuestChickenMiniGames = try? JSONDecoder().decode([CluckQuestChickenMiniGame].self, from: CluckQuestChickenData) else {
            return CluckQuestChickenCreateDefaultMiniGames()
        }
        return CluckQuestChickenMiniGames
    }
    
    func CluckQuestChickenSaveMiniGames(_ CluckQuestChickenMiniGames: [CluckQuestChickenMiniGame]) {
        if let CluckQuestChickenEncodedData = try? JSONEncoder().encode(CluckQuestChickenMiniGames) {
            CluckQuestChickenUserDefaults.set(CluckQuestChickenEncodedData, forKey: CluckQuestChickenMiniGamesKey)
        }
    }
    
    func CluckQuestChickenLoadAreas() -> [CluckQuestChickenFarmArea] {
        guard let CluckQuestChickenData = CluckQuestChickenUserDefaults.data(forKey: CluckQuestChickenAreasKey),
              let CluckQuestChickenAreas = try? JSONDecoder().decode([CluckQuestChickenFarmArea].self, from: CluckQuestChickenData) else {
            return CluckQuestChickenCreateDefaultAreas()
        }
        return CluckQuestChickenAreas
    }
    
    func CluckQuestChickenSaveAreas(_ CluckQuestChickenAreas: [CluckQuestChickenFarmArea]) {
        if let CluckQuestChickenEncodedData = try? JSONEncoder().encode(CluckQuestChickenAreas) {
            CluckQuestChickenUserDefaults.set(CluckQuestChickenEncodedData, forKey: CluckQuestChickenAreasKey)
        }
    }
    
    func CluckQuestChickenResetAllData() {
        CluckQuestChickenUserDefaults.removeObject(forKey: CluckQuestChickenPlayerDataKey)
        CluckQuestChickenUserDefaults.removeObject(forKey: CluckQuestChickenQuestsKey)
        CluckQuestChickenUserDefaults.removeObject(forKey: CluckQuestChickenAchievementsKey)
        CluckQuestChickenUserDefaults.removeObject(forKey: CluckQuestChickenFactsKey)
        CluckQuestChickenUserDefaults.removeObject(forKey: CluckQuestChickenMiniGamesKey)
        CluckQuestChickenUserDefaults.removeObject(forKey: CluckQuestChickenAreasKey)
        UserDefaults.standard.removeObject(forKey: "CluckQuestChickenHasOnboarded")
        UserDefaults.standard.removeObject(forKey: "CluckQuestChickenDailyChestLastOpened")
        UserDefaults.standard.removeObject(forKey: "CluckQuestChickenLastChestOpen")
        CluckQuestChickenInitializeData()
    }
    
    private func CluckQuestChickenCreateDefaultQuests() -> [CluckQuestChickenQuest] {
        return [
            CluckQuestChickenQuest(
                CluckQuestChickenQuestID: "first_exploration",
                CluckQuestChickenQuestTitle: "First Steps",
                CluckQuestChickenQuestDescription: "Explore your home coop area",
                CluckQuestChickenQuestEmoji: "🏠",
                CluckQuestChickenQuestType: .exploration,
                CluckQuestChickenQuestReward: CluckQuestChickenQuestReward(CluckQuestChickenRewardXP: 50, CluckQuestChickenRewardCoins: 25, CluckQuestChickenRewardItems: ["basic_feed"]),
                CluckQuestChickenQuestRequirements: []
            ),
            CluckQuestChickenQuest(
                CluckQuestChickenQuestID: "bug_hunt_master",
                CluckQuestChickenQuestTitle: "Bug Hunter",
                CluckQuestChickenQuestDescription: "Score 100 points in Bug Hunt",
                CluckQuestChickenQuestEmoji: "🐛",
                CluckQuestChickenQuestType: .minigame,
                CluckQuestChickenQuestReward: CluckQuestChickenQuestReward(CluckQuestChickenRewardXP: 75, CluckQuestChickenRewardCoins: 50, CluckQuestChickenRewardItems: ["golden_feed"]),
                CluckQuestChickenQuestRequirements: []
            )
        ]
    }
    
    private func CluckQuestChickenCreateDefaultAchievements() -> [CluckQuestChickenAchievement] {
        return [
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "first_quest",
                CluckQuestChickenAchievementTitle: "First Quest",
                CluckQuestChickenAchievementDescription: "Complete your first quest",
                CluckQuestChickenAchievementEmoji: "🎯",
                CluckQuestChickenAchievementRequirement: 1
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "coin_collector",
                CluckQuestChickenAchievementTitle: "Coin Collector",
                CluckQuestChickenAchievementDescription: "Collect 1000 CluckCoins",
                CluckQuestChickenAchievementEmoji: "🪙",
                CluckQuestChickenAchievementRequirement: 1000
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "farm_sweeper_10_wins",
                CluckQuestChickenAchievementTitle: "Farm Sweeper Pro",
                CluckQuestChickenAchievementDescription: "Win 10 times in Farm Sweeper",
                CluckQuestChickenAchievementEmoji: "🌾",
                CluckQuestChickenAchievementRequirement: 10
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "memory_match_10_wins",
                CluckQuestChickenAchievementTitle: "Memory Master",
                CluckQuestChickenAchievementDescription: "Win 10 times in Memory Match",
                CluckQuestChickenAchievementEmoji: "🧠",
                CluckQuestChickenAchievementRequirement: 10
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "tic_tac_toe_10_wins",
                CluckQuestChickenAchievementTitle: "Tic-Tac-Toe Champ",
                CluckQuestChickenAchievementDescription: "Win 10 times in Tic Tac Toe",
                CluckQuestChickenAchievementEmoji: "⭕️❌",
                CluckQuestChickenAchievementRequirement: 10
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "puzzle_assembly_10_wins",
                CluckQuestChickenAchievementTitle: "Puzzle Genius",
                CluckQuestChickenAchievementDescription: "Win 10 times in Puzzle Assembly",
                CluckQuestChickenAchievementEmoji: "🧩",
                CluckQuestChickenAchievementRequirement: 10
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "xp_1000",
                CluckQuestChickenAchievementTitle: "XP Collector",
                CluckQuestChickenAchievementDescription: "Earn 1000 XP in total",
                CluckQuestChickenAchievementEmoji: "⭐️",
                CluckQuestChickenAchievementRequirement: 1000
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "first_draw",
                CluckQuestChickenAchievementTitle: "First Draw",
                CluckQuestChickenAchievementDescription: "Get your first draw in Tic Tac Toe",
                CluckQuestChickenAchievementEmoji: "🤝",
                CluckQuestChickenAchievementRequirement: 1
            ),
            CluckQuestChickenAchievement(
                CluckQuestChickenAchievementID: "hundred_games",
                CluckQuestChickenAchievementTitle: "Game Addict",
                CluckQuestChickenAchievementDescription: "Play 100 games in total",
                CluckQuestChickenAchievementEmoji: "🎮",
                CluckQuestChickenAchievementRequirement: 100
            )
        ]
    }
    
    private func CluckQuestChickenCreateDefaultFacts() -> [CluckQuestChickenFarmFact] {
        return [
            CluckQuestChickenFarmFact(
                CluckQuestChickenFactID: "chicken_breeds",
                CluckQuestChickenFactTitle: "Chicken Breeds",
                CluckQuestChickenFactDescription: "There are over 500 different breeds of chickens worldwide",
                CluckQuestChickenFactEmoji: "🐔",
                CluckQuestChickenFactCategory: .chickens
            ),
            CluckQuestChickenFarmFact(
                CluckQuestChickenFactID: "mealworms",
                CluckQuestChickenFactTitle: "Mealworms",
                CluckQuestChickenFactDescription: "Mealworms are a favorite treat for chickens and provide protein",
                CluckQuestChickenFactEmoji: "🐛",
                CluckQuestChickenFactCategory: .pests
            )
        ]
    }
    
    private func CluckQuestChickenCreateDefaultMiniGames() -> [CluckQuestChickenMiniGame] {
        return [
            CluckQuestChickenMiniGame(
                CluckQuestChickenGameID: "bug_hunt",
                CluckQuestChickenGameName: "Bug Hunt",
                CluckQuestChickenGameEmoji: "🐛",
                CluckQuestChickenGameType: .spriteKit,
                CluckQuestChickenGameDescription: "Tap fast to catch mealworms"
            ),
            CluckQuestChickenMiniGame(
                CluckQuestChickenGameID: "grain_catch",
                CluckQuestChickenGameName: "Grain Catch",
                CluckQuestChickenGameEmoji: "🌾",
                CluckQuestChickenGameType: .uiKit,
                CluckQuestChickenGameDescription: "Tilt to roll seeds into baskets"
            ),
            CluckQuestChickenMiniGame(
                CluckQuestChickenGameID: "memory_match",
                CluckQuestChickenGameName: "Memory Match",
                CluckQuestChickenGameEmoji: "🧩",
                CluckQuestChickenGameType: .uiKit,
                CluckQuestChickenGameDescription: "Find matching farm emoji pairs"
            )
        ]
    }
    
    private func CluckQuestChickenCreateDefaultAreas() -> [CluckQuestChickenFarmArea] {
        return [
            CluckQuestChickenFarmArea(
                CluckQuestChickenAreaID: "HomeCoop",
                CluckQuestChickenAreaName: "Home Coop",
                CluckQuestChickenAreaEmoji: "🏠",
                CluckQuestChickenAreaDescription: "Your cozy home base",
                CluckQuestChickenAreaRequirements: [],
                CluckQuestChickenAreaUnlocked: true,
                CluckQuestChickenAreaQuests: ["first_exploration"],
                CluckQuestChickenAreaMiniGames: ["bug_hunt"]
            ),
            CluckQuestChickenFarmArea(
                CluckQuestChickenAreaID: "GardenPatch",
                CluckQuestChickenAreaName: "Garden Patch",
                CluckQuestChickenAreaEmoji: "🥕",
                CluckQuestChickenAreaDescription: "A bountiful vegetable garden",
                CluckQuestChickenAreaRequirements: ["first_exploration"],
                CluckQuestChickenAreaQuests: ["bug_hunt_master"],
                CluckQuestChickenAreaMiniGames: ["grain_catch", "memory_match"]
            )
        ]
    }
    

    private func CluckQuestChickenCheckAchievements() {
        var achievements = CluckQuestChickenLoadAchievements()
        let player = CluckQuestChickenLoadPlayerData()
        var changed = false
        for i in 0..<achievements.count {
            let ach = achievements[i]
            if ach.CluckQuestChickenAchievementUnlocked { continue }
            let unlocked: Bool = {
                switch ach.CluckQuestChickenAchievementID {
                case "first_quest":
                    return player.CluckQuestChickenCompletedQuests.count >= 1
                case "coin_collector":
                    return player.CluckQuestChickenCluckCoins >= 1000
                case "farm_sweeper_10_wins":
                    return player.CluckQuestChickenWins["farm_sweeper", default: 0] >= 10
                case "memory_match_10_wins":
                    return player.CluckQuestChickenWins["memory_match", default: 0] >= 10
                case "tic_tac_toe_10_wins":
                    return player.CluckQuestChickenWins["tic_tac_toe", default: 0] >= 10
                case "puzzle_assembly_10_wins":
                    return player.CluckQuestChickenWins["puzzle_assembly", default: 0] >= 10
                case "xp_1000":
                    return player.CluckQuestChickenXP >= 1000
                case "first_draw":
                    return player.CluckQuestChickenDraws["tic_tac_toe", default: 0] >= 1
                case "hundred_games":
                    let total = player.CluckQuestChickenWins.values.reduce(0, +) + player.CluckQuestChickenLosses.values.reduce(0, +) + player.CluckQuestChickenDraws.values.reduce(0, +)
                    return total >= 100
                default:
                    return false
                }
            }()
            if unlocked {
                achievements[i].CluckQuestChickenAchievementUnlocked = true
                changed = true
            }
        }
        if changed {
            CluckQuestChickenSaveAchievements(achievements)
        }
    }
    
    func incrementWin(for game: String) {
        var data = CluckQuestChickenLoadPlayerData()
        data.CluckQuestChickenWins[game, default: 0] += 1
        CluckQuestChickenSavePlayerData(data)
        CluckQuestChickenCheckAchievements()
    }
    func incrementLoss(for game: String) {
        var data = CluckQuestChickenLoadPlayerData()
        data.CluckQuestChickenLosses[game, default: 0] += 1
        CluckQuestChickenSavePlayerData(data)
        CluckQuestChickenCheckAchievements()
    }
    func incrementDraw(for game: String) {
        var data = CluckQuestChickenLoadPlayerData()
        data.CluckQuestChickenDraws[game, default: 0] += 1
        CluckQuestChickenSavePlayerData(data)
        CluckQuestChickenCheckAchievements()
    }
    func addXP(_ xp: Int) {
        var data = CluckQuestChickenLoadPlayerData()
        data.CluckQuestChickenXP += xp
        while data.CluckQuestChickenXP >= data.CluckQuestChickenLevel * 100 {
            data.CluckQuestChickenXP -= data.CluckQuestChickenLevel * 100
            data.CluckQuestChickenLevel += 1
        }
        CluckQuestChickenSavePlayerData(data)
        CluckQuestChickenCheckAchievements()
    }
    func addCoins(_ coins: Int) {
        var data = CluckQuestChickenLoadPlayerData()
        data.CluckQuestChickenCluckCoins += coins
        CluckQuestChickenSavePlayerData(data)
        CluckQuestChickenCheckAchievements()
    }
} 
