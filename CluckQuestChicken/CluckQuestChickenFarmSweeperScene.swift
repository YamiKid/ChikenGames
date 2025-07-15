import SpriteKit

protocol CluckQuestChickenFarmSweeperSceneDelegate: AnyObject {
    func CluckQuestChickenFarmSweeperDidReveal(r: Int, c: Int)
    func CluckQuestChickenFarmSweeperDidFlag(r: Int, c: Int)
}

class CluckQuestChickenFarmSweeperScene: SKScene {
    weak var CluckQuestChickenDelegate: CluckQuestChickenFarmSweeperSceneDelegate?
    var CluckQuestChickenBoard: [[CluckQuestChickenFarmSweeperCell]] = []
    private var CluckQuestChickenCellNodes: [[SKSpriteNode]] = []
    private var CluckQuestChickenCellSize: CGSize = .zero
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        CluckQuestChickenSetupBoard()
    }
    
    private func CluckQuestChickenSetupBoard() {
        removeAllChildren()
        CluckQuestChickenCellNodes = []
        let rows = CluckQuestChickenBoard.count
        let cols = CluckQuestChickenBoard.first?.count ?? 0
        let size = min(frame.width, frame.height) - 32
        let spacing: CGFloat = 8
        let cellSize = min((size - spacing * CGFloat(cols - 1)) / CGFloat(cols), (size - spacing * CGFloat(rows - 1)) / CGFloat(rows))
        CluckQuestChickenCellSize = CGSize(width: cellSize, height: cellSize)
        let totalW = CGFloat(cols) * cellSize + CGFloat(cols - 1) * spacing
        let totalH = CGFloat(rows) * cellSize + CGFloat(rows - 1) * spacing
        let startX = (frame.width - totalW) / 2 + cellSize/2
        let startY = frame.height - (frame.height - totalH) / 2 - cellSize/2
        for r in 0..<rows {
            var rowNodes: [SKSpriteNode] = []
            for c in 0..<cols {
                let node = SKSpriteNode(color: CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.withAlphaComponent(0.95), size: CluckQuestChickenCellSize)
                node.position = CGPoint(x: startX + CGFloat(c) * (cellSize + spacing), y: startY - CGFloat(r) * (cellSize + spacing))
                node.name = "cell_\(r)_\(c)"
                node.zPosition = 1

                let shape = SKShapeNode(rectOf: CluckQuestChickenCellSize, cornerRadius: 16)
                shape.fillColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.withAlphaComponent(0.95)
                shape.strokeColor = UIColor.white.withAlphaComponent(0.7)
                shape.lineWidth = 2
                shape.zPosition = 2
                node.addChild(shape)
                addChild(node)
                rowNodes.append(node)
            }
            CluckQuestChickenCellNodes.append(rowNodes)
        }
        for r in 0..<rows {
            for c in 0..<cols {
                CluckQuestChickenUpdateCellNode(r: r, c: c)
            }
        }
    }
    
    func CluckQuestChickenUpdateCellNode(r: Int, c: Int) {
        guard
            r >= 0, r < CluckQuestChickenBoard.count,
            c >= 0, c < CluckQuestChickenBoard[r].count,
            r < CluckQuestChickenCellNodes.count,
            c < CluckQuestChickenCellNodes[r].count
        else { return }
        let cell = CluckQuestChickenBoard[r][c]
        let node = CluckQuestChickenCellNodes[r][c]
        node.removeAllChildren()
        if cell.CluckQuestChickenIsRevealed {
            if cell.CluckQuestChickenIsMine {
                let label = SKLabelNode(text: "💣")
                label.fontSize = CluckQuestChickenCellSize.width * 0.8
                label.fontName = "SFProRounded-Semibold"
                label.verticalAlignmentMode = .center
                label.horizontalAlignmentMode = .center
                label.fontColor = UIColor.red
                node.addChild(label)
            } else if cell.CluckQuestChickenNeighborMines > 0 {
                let label = SKLabelNode(text: "\(cell.CluckQuestChickenNeighborMines)")
                label.fontSize = CluckQuestChickenCellSize.width * 0.8
                label.fontName = "SFProRounded-Semibold"
                label.verticalAlignmentMode = .center
                label.horizontalAlignmentMode = .center
                label.fontColor = UIColor.brown
                node.addChild(label)
            } else {
                let label = SKLabelNode(text: "")
                node.addChild(label)
            }
            node.alpha = 0.7
        } else if cell.CluckQuestChickenIsFlagged {
            let label = SKLabelNode(text: "🚩")
            label.fontSize = CluckQuestChickenCellSize.width * 0.8
            label.fontName = "SFProRounded-Semibold"
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            label.fontColor = UIColor.systemOrange
            node.addChild(label)
            node.alpha = 1.0
        } else {
            let label = SKLabelNode(text: "🌱")
            label.fontSize = CluckQuestChickenCellSize.width * 0.8
            label.fontName = "SFProRounded-Semibold"
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            label.fontColor = UIColor(red: 0.36, green: 0.54, blue: 0.36, alpha: 1)
            node.addChild(label)
            node.alpha = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        for r in 0..<CluckQuestChickenCellNodes.count {
            for c in 0..<CluckQuestChickenCellNodes[r].count {
                let node = CluckQuestChickenCellNodes[r][c]
                if node.contains(location) {
                    node.userData = ["touchStart": Date()]
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        for r in 0..<CluckQuestChickenCellNodes.count {
            for c in 0..<CluckQuestChickenCellNodes[r].count {
                let node = CluckQuestChickenCellNodes[r][c]
                if node.contains(location) {
                    if let start = node.userData?["touchStart"] as? Date, Date().timeIntervalSince(start) > 0.5 {
                        CluckQuestChickenDelegate?.CluckQuestChickenFarmSweeperDidFlag(r: r, c: c)
                    } else {
                        CluckQuestChickenDelegate?.CluckQuestChickenFarmSweeperDidReveal(r: r, c: c)
                    }
                    node.userData = nil
                    return
                }
            }
        }
    }
    
    func reloadBoard(_ newBoard: [[CluckQuestChickenFarmSweeperCell]]) {
        CluckQuestChickenBoard = newBoard
        CluckQuestChickenSetupBoard()
    }
} 
