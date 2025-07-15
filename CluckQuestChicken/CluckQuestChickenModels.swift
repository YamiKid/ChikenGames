import Foundation

struct CluckQuestChickenPlayerData: Codable {
    var CluckQuestChickenLevel: Int = 1
    var CluckQuestChickenXP: Int = 0
    var CluckQuestChickenCluckCoins: Int = 100
    var CluckQuestChickenWins: [String: Int] = ["memory_match": 0, "farm_sweeper": 0, "tic_tac_toe": 0, "puzzle_assembly": 0]
    var CluckQuestChickenLosses: [String: Int] = ["memory_match": 0, "farm_sweeper": 0, "tic_tac_toe": 0, "puzzle_assembly": 0]
    var CluckQuestChickenDraws: [String: Int] = ["tic_tac_toe": 0]
    var CluckQuestChickenUnlockedAreas: [String] = ["HomeCoop"]
    var CluckQuestChickenInventory: [CluckQuestChickenInventoryItem] = []
    var CluckQuestChickenCompletedQuests: [String] = []
    var CluckQuestChickenMiniGameScores: [String: Int] = [:]
    var CluckQuestChickenPuzzleRecords: [String: Int] = [:]
    var CluckQuestChickenCoopBotMode: CluckQuestChickenCoopBotMode = .friendly
}

struct CluckQuestChickenInventoryItem: Codable {
    let CluckQuestChickenItemID: String
    let CluckQuestChickenItemName: String
    let CluckQuestChickenItemEmoji: String
    let CluckQuestChickenItemType: CluckQuestChickenItemType
    var CluckQuestChickenItemQuantity: Int
}

enum CluckQuestChickenItemType: String, Codable {
    case tool
    case outfit
    case food
    case treasure
}

enum CluckQuestChickenCoopBotMode: String, Codable, CaseIterable {
    case friendly = "Friendly"
    case chirpy = "Chirpy"
    case silent = "Silent"
}

struct CluckQuestChickenQuest: Codable {
    let CluckQuestChickenQuestID: String
    let CluckQuestChickenQuestTitle: String
    let CluckQuestChickenQuestDescription: String
    let CluckQuestChickenQuestEmoji: String
    let CluckQuestChickenQuestType: CluckQuestChickenQuestType
    let CluckQuestChickenQuestReward: CluckQuestChickenQuestReward
    let CluckQuestChickenQuestRequirements: [String]
    var CluckQuestChickenQuestCompleted: Bool = false
}

enum CluckQuestChickenQuestType: String, Codable {
    case exploration
    case minigame
    case puzzle
    case collection
}

struct CluckQuestChickenQuestReward: Codable {
    let CluckQuestChickenRewardXP: Int
    let CluckQuestChickenRewardCoins: Int
    let CluckQuestChickenRewardItems: [String]?
}

struct CluckQuestChickenAchievement: Codable {
    let CluckQuestChickenAchievementID: String
    let CluckQuestChickenAchievementTitle: String
    let CluckQuestChickenAchievementDescription: String
    let CluckQuestChickenAchievementEmoji: String
    var CluckQuestChickenAchievementUnlocked: Bool = false
    let CluckQuestChickenAchievementRequirement: Int
}

struct CluckQuestChickenFarmFact: Codable {
    let CluckQuestChickenFactID: String
    let CluckQuestChickenFactTitle: String
    let CluckQuestChickenFactDescription: String
    let CluckQuestChickenFactEmoji: String
    let CluckQuestChickenFactCategory: CluckQuestChickenFactCategory
}

enum CluckQuestChickenFactCategory: String, Codable, CaseIterable {
    case chickens = "Chickens"
    case pests = "Pests"
    case tools = "Tools"
    case plants = "Plants"
}

struct CluckQuestChickenMiniGame: Codable {
    let CluckQuestChickenGameID: String
    let CluckQuestChickenGameName: String
    let CluckQuestChickenGameEmoji: String
    let CluckQuestChickenGameType: CluckQuestChickenGameType
    let CluckQuestChickenGameDescription: String
    var CluckQuestChickenGameHighScore: Int = 0
}

enum CluckQuestChickenGameType: String, Codable {
    case spriteKit = "SpriteKit"
    case uiKit = "UIKit"
}

struct CluckQuestChickenFarmArea: Codable {
    let CluckQuestChickenAreaID: String
    let CluckQuestChickenAreaName: String
    let CluckQuestChickenAreaEmoji: String
    let CluckQuestChickenAreaDescription: String
    let CluckQuestChickenAreaRequirements: [String]
    var CluckQuestChickenAreaUnlocked: Bool = false
    let CluckQuestChickenAreaQuests: [String]
    let CluckQuestChickenAreaMiniGames: [String]
} 