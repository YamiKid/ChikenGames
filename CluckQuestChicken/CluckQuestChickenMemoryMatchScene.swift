import SpriteKit

protocol CluckQuestChickenMemoryMatchSceneDelegate: AnyObject {
    func CluckQuestChickenMemoryDidFlip(index: Int)
}

class CluckQuestChickenMemoryMatchScene: SKScene {
    weak var CluckQuestChickenDelegate: CluckQuestChickenMemoryMatchSceneDelegate?
    var cards: [CluckQuestChickenMemoryCard] = []
    var cols: Int = 3
    var rows: Int = 4
    private var cardNodes: [SKSpriteNode] = []
    private var currentlyFlipping: Set<Int> = []
    var isBusy: Bool = false

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        setupCards()
    }

    private func gridSize(for count: Int) -> (cols: Int, rows: Int) {
        switch count {
        case 12: return (3, 4)
        case 16: return (4, 4)
        case 20: return (5, 4)
        default:
            let side = Int(sqrt(Double(count)))
            return (side, (count + side - 1) / side)
        }
    }

    func setupCards() {
        removeAllChildren()
        cardNodes = []
        let count = cards.count
        let (cols, rows) = gridSize(for: count)
        let cardSize: CGFloat = min(self.size.width / CGFloat(cols), self.size.height / CGFloat(rows)) * 0.85
        let totalW = CGFloat(cols) * cardSize + CGFloat(cols-1) * 8
        let totalH = CGFloat(rows) * cardSize + CGFloat(rows-1) * 8
        let startX = (self.size.width - totalW) / 2 + cardSize/2
        let startY = self.size.height - (self.size.height - totalH) / 2 - cardSize/2
        for i in 0..<cards.count {
            let row = i / cols
            let col = i % cols
            let shape = SKShapeNode(rectOf: CGSize(width: cardSize, height: cardSize), cornerRadius: cardSize*0.24)
            shape.fillColor = UIColor(red: 0.66, green: 0.84, blue: 0.73, alpha: 1)
            shape.strokeColor = UIColor(white: 1.0, alpha: 0.7)
            shape.lineWidth = 2.5
            shape.zPosition = 0
            shape.position = .zero
            let node = SKSpriteNode(color: .clear, size: CGSize(width: cardSize, height: cardSize))
            node.position = CGPoint(x: startX + CGFloat(col)*(cardSize+8), y: startY - CGFloat(row)*(cardSize+8))
            node.name = "card_\(i)"
            node.zPosition = 2
            node.removeAllChildren()
            node.removeAllActions()
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.alpha = cards[i].isMatched ? 0.3 : 1.0
            node.addChild(shape)
            let emojiLabel = SKLabelNode(text: cards[i].emoji)
            emojiLabel.fontSize = 28
            emojiLabel.fontName = "SFProRounded-Semibold"
            emojiLabel.verticalAlignmentMode = .center
            emojiLabel.horizontalAlignmentMode = .center
            emojiLabel.fontColor = UIColor(red: 0.22, green: 0.32, blue: 0.18, alpha: 1)
            emojiLabel.zPosition = 1
            emojiLabel.alpha = (cards[i].isFaceUp || cards[i].isMatched) ? 1.0 : 0.0
            emojiLabel.name = "emojiLabel"
            node.addChild(emojiLabel)
            cardNodes.append(node)
            addChild(node)
        }
    }

    func updateCardNode(_ i: Int, animated: Bool = true) {
        let card = cards[i]
        let node = cardNodes[i]
        guard let emojiLabel = node.childNode(withName: "emojiLabel") as? SKLabelNode else { return }
        let shouldShow = card.isFaceUp || card.isMatched
        let targetAlpha: CGFloat = shouldShow ? 1.0 : 0.0
        node.alpha = card.isMatched ? 0.3 : 1.0
        if animated {
            emojiLabel.run(SKAction.fadeAlpha(to: targetAlpha, duration: 0.18))
        } else {
            emojiLabel.alpha = targetAlpha
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if isBusy { return }
        for (i, node) in cardNodes.enumerated() {
            let card = cards[i]
            if node.contains(location) && !currentlyFlipping.contains(i) && !card.isFaceUp && !card.isMatched {
                isBusy = true
                let flip1 = SKAction.scaleX(to: 0.01, duration: 0.18)
                let flip2 = SKAction.scaleX(to: 1.0, duration: 0.18)
                let showEmoji = SKAction.run { [weak self] in
                    self?.updateCardNode(i, animated: true)
                }
                let done = SKAction.run { [weak self] in
                    self?.isBusy = false
                    self?.CluckQuestChickenDelegate?.CluckQuestChickenMemoryDidFlip(index: i)
                }
                let seq = SKAction.sequence([flip1, showEmoji, flip2, done])
                node.run(seq)
                break
            }
        }
    }

    func updateAllCardsAnimated(oldCards: [CluckQuestChickenMemoryCard]) {
        for i in 0..<cards.count {
            let old = oldCards[i]
            let new = cards[i]
            let node = cardNodes[i]
            if old.isFaceUp && !new.isFaceUp {
                updateCardNode(i, animated: true)
            } else if !old.isMatched && new.isMatched {
                node.alpha = 0.3
                updateCardNode(i, animated: true)
            } else if !old.isFaceUp && new.isFaceUp {
                updateCardNode(i, animated: true)
            } else if !new.isFaceUp && !new.isMatched {
                updateCardNode(i, animated: false)
            }
        }
    }
} 
