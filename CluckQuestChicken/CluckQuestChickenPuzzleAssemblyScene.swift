import SpriteKit

protocol CluckQuestChickenPuzzleAssemblySceneDelegate: AnyObject {
    func CluckQuestChickenPuzzleDidMove()
    func CluckQuestChickenPuzzleDidComplete()
}

class CluckQuestChickenPuzzleAssemblyScene: SKScene {
    weak var CluckQuestChickenDelegate: CluckQuestChickenPuzzleAssemblySceneDelegate?
    var CluckQuestChickenImageName: String = "CluckQuestChickenImg1"
    var CluckQuestChickenGridSize: Int = 3
    private var CluckQuestChickenTiles: [SKSpriteNode] = []
    private var CluckQuestChickenTileOrder: [Int] = []
    private var CluckQuestChickenEmptyIndex: Int = 0
    private var CluckQuestChickenTileSize: CGSize = .zero
    private var CluckQuestChickenDraggingTile: SKSpriteNode?
    private var CluckQuestChickenDraggingIndex: Int?
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        CluckQuestChickenSetupTiles()
    }
    
    private func CluckQuestChickenSetupTiles() {
        removeAllChildren()
        let size = min(frame.width, frame.height) - 32
        CluckQuestChickenTileSize = CGSize(width: size/CGFloat(CluckQuestChickenGridSize), height: size/CGFloat(CluckQuestChickenGridSize))
        let image = UIImage(named: CluckQuestChickenImageName) ?? UIImage()
        let emojiOverlay = "🐔"
        var pieces: [UIImage] = []
        for row in 0..<CluckQuestChickenGridSize {
            for col in 0..<CluckQuestChickenGridSize {
                let rect = CGRect(x: CGFloat(col)/CGFloat(CluckQuestChickenGridSize), y: CGFloat(row)/CGFloat(CluckQuestChickenGridSize), width: 1/CGFloat(CluckQuestChickenGridSize), height: 1/CGFloat(CluckQuestChickenGridSize))
                if let cg = image.cgImage?.cropping(to: CGRect(x: rect.origin.x*image.size.width, y: rect.origin.y*image.size.height, width: rect.size.width*image.size.width, height: rect.size.height*image.size.height)) {
                    var piece = UIImage(cgImage: cg)
                    UIGraphicsBeginImageContextWithOptions(piece.size, false, 0)
                    piece.draw(in: CGRect(origin: .zero, size: piece.size))
                    let attrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: piece.size.width/2)
                    ]
                    let emoji = (row+col)%2 == 0 ? emojiOverlay : "🌾"
                    (emoji as NSString).draw(in: CGRect(x: piece.size.width/4, y: piece.size.height/4, width: piece.size.width/2, height: piece.size.height/2), withAttributes: attrs)
                    piece = UIGraphicsGetImageFromCurrentImageContext() ?? piece
                    UIGraphicsEndImageContext()
                    pieces.append(piece)
                }
            }
        }
        CluckQuestChickenTileOrder = Array(0..<(CluckQuestChickenGridSize*CluckQuestChickenGridSize))
        CluckQuestChickenTileOrder.shuffle()
        for i in 0..<CluckQuestChickenTileOrder.count {
            let idx = CluckQuestChickenTileOrder[i]
            let row = i / CluckQuestChickenGridSize
            let col = i % CluckQuestChickenGridSize
            let tile = SKSpriteNode(texture: SKTexture(image: pieces[idx]))
            tile.size = CluckQuestChickenTileSize
            tile.position = CGPoint(x: CGFloat(col)*CluckQuestChickenTileSize.width + CluckQuestChickenTileSize.width/2 + 16, y: frame.height - CGFloat(row)*CluckQuestChickenTileSize.height - CluckQuestChickenTileSize.height/2 - 16)
            tile.name = "tile_\(i)"
            tile.zPosition = 1
            tile.isUserInteractionEnabled = false
            addChild(tile)
            CluckQuestChickenTiles.append(tile)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        for (i, tile) in CluckQuestChickenTiles.enumerated() {
            if tile.contains(location) {
                CluckQuestChickenDraggingTile = tile
                CluckQuestChickenDraggingIndex = i
                tile.zPosition = 10
                break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let tile = CluckQuestChickenDraggingTile else { return }
        let location = touch.location(in: self)
        tile.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tile = CluckQuestChickenDraggingTile, let from = CluckQuestChickenDraggingIndex else { return }
        let location = touches.first?.location(in: self) ?? .zero
        for (to, other) in CluckQuestChickenTiles.enumerated() {
            if other != tile && other.contains(location) {
                let temp = tile.position
                tile.position = other.position
                other.position = temp
                CluckQuestChickenTiles.swapAt(from, to)
                CluckQuestChickenDelegate?.CluckQuestChickenPuzzleDidMove()
                if CluckQuestChickenIsSolved() {
                    CluckQuestChickenDelegate?.CluckQuestChickenPuzzleDidComplete()
                }
                break
            }
        }
        tile.zPosition = 1
        CluckQuestChickenDraggingTile = nil
        CluckQuestChickenDraggingIndex = nil
    }
    
    private func CluckQuestChickenIsSolved() -> Bool {
        for (i, tile) in CluckQuestChickenTiles.enumerated() {
            if tile.name != "tile_\(i)" { return false }
        }
        return true
    }
} 