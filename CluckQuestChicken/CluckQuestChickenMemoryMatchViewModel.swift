import Foundation

struct CluckQuestChickenMemoryCard {
    let id: Int
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

class CluckQuestChickenMemoryMatchViewModel {

    let gridSizes = ["Easy": (cols: 3, rows: 4), "Medium": (cols: 4, rows: 4), "Hard": (cols: 5, rows: 4)]
    let emojis = [
        "🐔", "🐣", "🐥", "🐤", "🐓", "🐄", "🐖", "🐑", "🦆", "🦋", "🐝", "🐇", "🌾", "🌻", "🥕", "🍎", "🍯", "🥚", "🪶", "🌱", "🍀", "🌼", "🌽", "🍉", "🍓", "🦃", "🦚", "🦢", "🦔", "🦦", "🦩", "🦜", "🦡"
    ]
    var selectedDifficulty: String = "Easy"
    var cardCount: Int {
        let size = gridSizes[selectedDifficulty] ?? (3, 4)
        return size.cols * size.rows
    }
    var cards: [CluckQuestChickenMemoryCard] = []
    private(set) var firstFlippedIndex: Int? = nil
    private(set) var isBusy: Bool = false
    var timer: Timer?
    var elapsed: Int = 0
    var flips: Int = 0
    var onUpdate: (() -> Void)?
    var onComplete: ((Int, Int) -> Void)?

    func startGame() {
        let pairs = cardCount / 2
        let chosen = Array(emojis.shuffled().prefix(pairs))
        var allCards: [CluckQuestChickenMemoryCard] = []
        for (idx, emoji) in chosen.enumerated() {
            allCards.append(CluckQuestChickenMemoryCard(id: idx*2, emoji: emoji))
            allCards.append(CluckQuestChickenMemoryCard(id: idx*2+1, emoji: emoji))
        }
        allCards.shuffle()
        cards = allCards
        firstFlippedIndex = nil
        elapsed = 0
        flips = 0
        isBusy = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.elapsed += 1
            self?.onUpdate?()
        }
        onUpdate?()
    }

    func flipCard(at index: Int) {
        guard !cards[index].isMatched, !cards[index].isFaceUp, !isBusy else { return }
        cards[index].isFaceUp = true
        flips += 1
        if let first = firstFlippedIndex {
            isBusy = true
            onUpdate?()
            if cards[first].emoji == cards[index].emoji {

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.cards[first].isMatched = true
                    self.cards[index].isMatched = true
                    self.firstFlippedIndex = nil
                    self.isBusy = false
                    if self.cards.allSatisfy({ $0.isMatched }) {
                        self.timer?.invalidate()
                        self.onComplete?(self.elapsed, self.flips)
                    }
                    self.onUpdate?()
                }
            } else {

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.cards[first].isFaceUp = false
                    self.cards[index].isFaceUp = false
                    self.firstFlippedIndex = nil
                    self.isBusy = false
                    self.onUpdate?()
                }
            }
        } else {
            firstFlippedIndex = index
            onUpdate?()
        }
    }

    func xpAndCoins() -> (Int, Int) {
        let baseXP = 10 * cardCount
        let baseCoins = 5 * cardCount
        let bonus = max(0, 100 - elapsed - flips)
        return (baseXP + bonus, baseCoins + bonus/2)
    }
} 
