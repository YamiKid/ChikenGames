import UIKit

class CluckQuestChickenPuzzleAssemblyViewController: UIViewController {
    var CluckQuestSelectedImage: String = "CluckQuestChickenImg1"
    var CluckQuestSelectedDifficulty: String = "Easy"
    private let CluckQuestChickenViewModel = CluckQuestChickenPuzzleAssemblyViewModel()
    
    private let CluckQuestChickenPreview = UIImageView()
    private let CluckQuestChickenGridContainer = UIStackView()
    private var CluckQuestChickenGridCells: [[UIView]] = []
    private let CluckQuestChickenPiecesScroll = UIScrollView()
    private let CluckQuestChickenPiecesStack = UIStackView()
    private var CluckQuestChickenPieceData: [(image: UIImage, index: Int)] = []
    private var CluckQuestChickenPieceViews: [UIImageView] = []
    private var CluckQuestChickenPlaced: [[UIImageView?]] = []
    private var CluckQuestChickenGridSize: Int { CluckQuestChickenViewModel.CluckQuestChickenDifficulties[CluckQuestSelectedDifficulty] ?? 3 }
    private var CluckQuestChickenSelectedPiece: UIImageView?
    private let CluckQuestChickenHUD = UIView()
    private let CluckQuestChickenTimerLabel = UILabel()
    private let CluckQuestChickenMovesLabel = UILabel()
    private let CluckQuestChickenBestLabel = UILabel()
    private let CluckQuestChickenXPLabel = UILabel()
    private let CluckQuestChickenCoinsLabel = UILabel()
    private var CluckQuestChickenTimer: Timer?
    private var CluckQuestChickenElapsed: Int = 0
    private var CluckQuestChickenMoves: Int = 0
    private var CluckQuestChickenBest: Int = 0
    private var CluckQuestChickenXP: Int = 0
    private var CluckQuestChickenCoins: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Puzzle Assembly"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(CluckQuestChickenBackTapped))
        CluckQuestChickenSetupPreview()
        CluckQuestChickenSetupGrid()
        CluckQuestChickenSetupPiecesScroll()
        CluckQuestChickenSliceImage()
        CluckQuestChickenSetupPieces()
        CluckQuestChickenSetupHUD()
        CluckQuestChickenStartGame()
    }
    
    @objc private func CluckQuestChickenBackTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func CluckQuestChickenSetupHUD() {
        CluckQuestChickenHUD.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.7)
        CluckQuestChickenHUD.layer.cornerRadius = 16
        CluckQuestChickenHUD.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenHUD)
        CluckQuestChickenTimerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenTimerLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenMovesLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenMovesLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenBestLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenBestLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        CluckQuestChickenXPLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        CluckQuestChickenXPLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        CluckQuestChickenCoinsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        CluckQuestChickenCoinsLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenTimerLabel, CluckQuestChickenMovesLabel, CluckQuestChickenBestLabel, CluckQuestChickenXPLabel, CluckQuestChickenCoinsLabel])
        stack.axis = .horizontal
        stack.spacing = 18
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenHUD.addSubview(stack)
        NSLayoutConstraint.activate([
            CluckQuestChickenHUD.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            CluckQuestChickenHUD.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenHUD.heightAnchor.constraint(equalToConstant: 44),
            CluckQuestChickenHUD.widthAnchor.constraint(equalToConstant: 340),
            stack.centerXAnchor.constraint(equalTo: CluckQuestChickenHUD.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: CluckQuestChickenHUD.centerYAnchor)
        ])
    }
    
    private func CluckQuestChickenSetupPreview() {
        CluckQuestChickenPreview.contentMode = .scaleAspectFit
        CluckQuestChickenPreview.layer.cornerRadius = 16
        CluckQuestChickenPreview.clipsToBounds = true
        CluckQuestChickenPreview.backgroundColor = .white
        CluckQuestChickenPreview.image = UIImage(named: CluckQuestSelectedImage)
        CluckQuestChickenPreview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenPreview)
        NSLayoutConstraint.activate([
            CluckQuestChickenPreview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            CluckQuestChickenPreview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenPreview.widthAnchor.constraint(equalToConstant: 160),
            CluckQuestChickenPreview.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func CluckQuestChickenSetupGrid() {
        CluckQuestChickenGridContainer.axis = .vertical
        CluckQuestChickenGridContainer.spacing = 4
        CluckQuestChickenGridContainer.alignment = .center
        CluckQuestChickenGridContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenGridContainer)
        NSLayoutConstraint.activate([
            CluckQuestChickenGridContainer.topAnchor.constraint(equalTo: CluckQuestChickenPreview.bottomAnchor, constant: 16),
            CluckQuestChickenGridContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenGridContainer.widthAnchor.constraint(equalToConstant: CGFloat(CluckQuestChickenGridSize) * 50 + CGFloat(CluckQuestChickenGridSize - 1) * 4),
            CluckQuestChickenGridContainer.heightAnchor.constraint(equalToConstant: CGFloat(CluckQuestChickenGridSize) * 50 + CGFloat(CluckQuestChickenGridSize - 1) * 4)
        ])
        CluckQuestChickenGridCells = []
        CluckQuestChickenPlaced = Array(repeating: Array(repeating: nil, count: CluckQuestChickenGridSize), count: CluckQuestChickenGridSize)
        for row in 0..<CluckQuestChickenGridSize {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = 4
            hStack.alignment = .center
            hStack.distribution = .fillEqually
            var rowCells: [UIView] = []
            for col in 0..<CluckQuestChickenGridSize {
                let cell = UIView()
                cell.backgroundColor = UIColor(white: 0.85, alpha: 1)
                cell.layer.cornerRadius = 8
                cell.layer.borderWidth = 1
                cell.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.cgColor
                cell.translatesAutoresizingMaskIntoConstraints = false
                cell.widthAnchor.constraint(equalToConstant: 50).isActive = true
                cell.heightAnchor.constraint(equalToConstant: 50).isActive = true
                cell.tag = row * CluckQuestChickenGridSize + col
                let tap = UITapGestureRecognizer(target: self, action: #selector(CluckQuestChickenGridCellTapped(_:)))
                cell.addGestureRecognizer(tap)
                hStack.addArrangedSubview(cell)
                rowCells.append(cell)
            }
            CluckQuestChickenGridContainer.addArrangedSubview(hStack)
            CluckQuestChickenGridCells.append(rowCells)
        }
    }
    
    private func CluckQuestChickenSetupPiecesScroll() {
        CluckQuestChickenPiecesScroll.showsHorizontalScrollIndicator = false
        CluckQuestChickenPiecesScroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenPiecesScroll)
        NSLayoutConstraint.activate([
            CluckQuestChickenPiecesScroll.topAnchor.constraint(equalTo: CluckQuestChickenGridContainer.bottomAnchor, constant: 24),
            CluckQuestChickenPiecesScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            CluckQuestChickenPiecesScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            CluckQuestChickenPiecesScroll.heightAnchor.constraint(equalToConstant: 60)
        ])
        CluckQuestChickenPiecesStack.axis = .horizontal
        CluckQuestChickenPiecesStack.spacing = 12
        CluckQuestChickenPiecesStack.alignment = .center
        CluckQuestChickenPiecesStack.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenPiecesScroll.addSubview(CluckQuestChickenPiecesStack)
        NSLayoutConstraint.activate([
            CluckQuestChickenPiecesStack.topAnchor.constraint(equalTo: CluckQuestChickenPiecesScroll.topAnchor),
            CluckQuestChickenPiecesStack.bottomAnchor.constraint(equalTo: CluckQuestChickenPiecesScroll.bottomAnchor),
            CluckQuestChickenPiecesStack.leadingAnchor.constraint(equalTo: CluckQuestChickenPiecesScroll.leadingAnchor),
            CluckQuestChickenPiecesStack.trailingAnchor.constraint(equalTo: CluckQuestChickenPiecesScroll.trailingAnchor),
            CluckQuestChickenPiecesStack.heightAnchor.constraint(equalTo: CluckQuestChickenPiecesScroll.heightAnchor)
        ])
    }
    
    private func CluckQuestChickenSliceImage() {
        guard let image = UIImage(named: CluckQuestSelectedImage) else { return }
        let grid = CluckQuestChickenGridSize
        let size = image.size
        let tileW = size.width / CGFloat(grid)
        let tileH = size.height / CGFloat(grid)
        var pieces: [(UIImage, Int)] = []
        var idx = 0
        for row in 0..<grid {
            for col in 0..<grid {
                let rect = CGRect(x: CGFloat(col)*tileW, y: CGFloat(row)*tileH, width: tileW, height: tileH)
                if let cg = image.cgImage?.cropping(to: rect) {
                    let piece = UIImage(cgImage: cg)
                    pieces.append((piece, idx))
                }
                idx += 1
            }
        }
        CluckQuestChickenPieceData = pieces.shuffled()
    }
    
    private func CluckQuestChickenSetupPieces() {
        CluckQuestChickenPieceViews = []
        for (i, data) in CluckQuestChickenPieceData.enumerated() {
            let img = data.image
            let origIdx = data.index
            let pieceView = UIImageView(image: img)
            pieceView.isUserInteractionEnabled = true
            pieceView.layer.cornerRadius = 8
            pieceView.clipsToBounds = true
            pieceView.layer.borderWidth = 1
            pieceView.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.cgColor
            pieceView.contentMode = .scaleAspectFill
            pieceView.tag = origIdx
            pieceView.translatesAutoresizingMaskIntoConstraints = false
            pieceView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            pieceView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(CluckQuestChickenPieceTapped(_:)))
            pieceView.addGestureRecognizer(tap)
            CluckQuestChickenPiecesStack.addArrangedSubview(pieceView)
            CluckQuestChickenPieceViews.append(pieceView)
        }
    }
    
    @objc private func CluckQuestChickenPieceTapped(_ sender: UITapGestureRecognizer) {
        guard let pieceView = sender.view as? UIImageView else { return }

        for view in CluckQuestChickenPieceViews {
            view.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.cgColor
            view.layer.borderWidth = 1
            view.layer.shadowOpacity = 0
        }

        pieceView.layer.borderColor = UIColor.systemBlue.cgColor
        pieceView.layer.borderWidth = 3
        pieceView.layer.shadowColor = UIColor.systemBlue.cgColor
        pieceView.layer.shadowRadius = 6
        pieceView.layer.shadowOpacity = 0.4
        pieceView.layer.shadowOffset = CGSize(width: 0, height: 0)
        CluckQuestChickenSelectedPiece = pieceView
    }
    
    @objc private func CluckQuestChickenGridCellTapped(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view else { return }
        let tag = cell.tag
        let row = tag / CluckQuestChickenGridSize
        let col = tag % CluckQuestChickenGridSize
        guard let selectedPiece = CluckQuestChickenSelectedPiece else { return }

        let correctIndex = row * CluckQuestChickenGridSize + col
        if selectedPiece.tag == correctIndex {

            CluckQuestChickenPlaced[row][col]?.removeFromSuperview()

            for r in 0..<CluckQuestChickenGridSize {
                for c in 0..<CluckQuestChickenGridSize {
                    if CluckQuestChickenPlaced[r][c] === selectedPiece {
                        CluckQuestChickenPlaced[r][c] = nil
                    }
                }
            }

            cell.addSubview(selectedPiece)
            selectedPiece.frame = cell.bounds
            selectedPiece.center = CGPoint(x: cell.bounds.midX, y: cell.bounds.midY)
            CluckQuestChickenPlaced[row][col] = selectedPiece

            selectedPiece.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.cgColor
            selectedPiece.layer.borderWidth = 1
            selectedPiece.layer.shadowOpacity = 0
            CluckQuestChickenSelectedPiece = nil
            CluckQuestChickenIncrementMoves()
            CluckQuestChickenCheckCompletion()
        } else {

            let oldColor = cell.backgroundColor
            cell.backgroundColor = UIColor.systemRed
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                cell.backgroundColor = oldColor
            }
        }
    }
    
    private func CluckQuestChickenStartGame() {
        CluckQuestChickenElapsed = 0
        CluckQuestChickenMoves = 0
        CluckQuestChickenXP = 0
        CluckQuestChickenCoins = 0
        CluckQuestChickenTimerLabel.text = "00:00"
        CluckQuestChickenMovesLabel.text = "Moves: 0"
        CluckQuestChickenXPLabel.text = ""
        CluckQuestChickenCoinsLabel.text = ""
        let bestKey = "CluckQuestChickenPuzzleBest_\(CluckQuestSelectedImage)_\(CluckQuestSelectedDifficulty)"
        CluckQuestChickenBest = UserDefaults.standard.integer(forKey: bestKey)
        CluckQuestChickenBestLabel.text = CluckQuestChickenBest > 0 ? "Best: \(CluckQuestChickenBest)s" : "Best: —"
        CluckQuestChickenTimer?.invalidate()
        CluckQuestChickenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.CluckQuestChickenElapsed += 1
            self.CluckQuestChickenTimerLabel.text = String(format: "%02d:%02d", self.CluckQuestChickenElapsed/60, self.CluckQuestChickenElapsed%60)
        }
    }
    
    private func CluckQuestChickenIncrementMoves() {
        CluckQuestChickenMoves += 1
        CluckQuestChickenMovesLabel.text = "Moves: \(CluckQuestChickenMoves)"
    }
    
    private func CluckQuestChickenCheckCompletion() {
        for row in 0..<CluckQuestChickenGridSize {
            for col in 0..<CluckQuestChickenGridSize {
                guard let piece = CluckQuestChickenPlaced[row][col] else { return }
                let correctIndex = row * CluckQuestChickenGridSize + col
                if piece.tag != correctIndex {
                    return
                }
            }
        }
        CluckQuestChickenTimer?.invalidate()
        let grid = CluckQuestChickenGridSize
        let baseXP = max(5, 20 * grid - CluckQuestChickenMoves)
        let baseCoins = max(3, 10 * grid - CluckQuestChickenElapsed)
        CluckQuestChickenXP = baseXP
        CluckQuestChickenCoins = baseCoins
        CluckQuestChickenXPLabel.text = "+\(baseXP) XP"
        CluckQuestChickenCoinsLabel.text = "+\(baseCoins) Coins"
        let bestKey = "CluckQuestChickenPuzzleBest_\(CluckQuestSelectedImage)_\(CluckQuestSelectedDifficulty)"
        if CluckQuestChickenBest == 0 || CluckQuestChickenElapsed < CluckQuestChickenBest {
            UserDefaults.standard.set(CluckQuestChickenElapsed, forKey: bestKey)
            CluckQuestChickenBestLabel.text = "Best: \(CluckQuestChickenElapsed)s"
        }
        let vc = CluckQuestChickenPuzzleAssemblyCompletionViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.CluckQuestChickenTime = CluckQuestChickenElapsed
        vc.CluckQuestChickenMoves = CluckQuestChickenMoves
        vc.CluckQuestChickenXP = baseXP
        vc.CluckQuestChickenCoins = baseCoins
        present(vc, animated: true)
    }
} 
