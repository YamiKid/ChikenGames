import UIKit

struct CluckQuestChickenGameMenuItem {
    let CluckQuestChickenEmoji: String
    let CluckQuestChickenTitle: String
    let CluckQuestChickenSubtitle: String
}

class CluckQuestChickenGamesViewModel {
    let CluckQuestChickenGames: [CluckQuestChickenGameMenuItem] = [
        CluckQuestChickenGameMenuItem(
            CluckQuestChickenEmoji: "🧩",
            CluckQuestChickenTitle: "Puzzle",
            CluckQuestChickenSubtitle: "Rebuild farm images"
        ),
        CluckQuestChickenGameMenuItem(
            CluckQuestChickenEmoji: "❌⭕️",
            CluckQuestChickenTitle: "Tic-Tac-Toe",
            CluckQuestChickenSubtitle: "Beat the AI!"
        ),
        CluckQuestChickenGameMenuItem(
            CluckQuestChickenEmoji: "🃏",
            CluckQuestChickenTitle: "Memory Match",
            CluckQuestChickenSubtitle: "Find all pairs"
        ),
        CluckQuestChickenGameMenuItem(
            CluckQuestChickenEmoji: "💣",
            CluckQuestChickenTitle: "Farm Sweeper",
            CluckQuestChickenSubtitle: "Avoid the mines!"
        )
    ]
}

class CluckQuestChickenGamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let CluckQuestChickenViewModel = CluckQuestChickenGamesViewModel()
    private var CluckQuestChickenCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Games"
        CluckQuestChickenSetupBackground()
        CluckQuestChickenSetupCollectionView()
    }
    
    private func CluckQuestChickenSetupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.cgColor,
            CluckQuestChickenDesignSystem.CluckQuestChickenSageMeadow.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        for _ in 0..<8 {
            let emoji = ["🌾", "🐔", "🍅", "🐛"].randomElement()!
            let label = UILabel()
            label.text = emoji
            label.font = UIFont.systemFont(ofSize: CGFloat.random(in: 32...54))
            label.alpha = 0.13
            let x = CGFloat.random(in: 0...(view.bounds.width-60))
            let y = CGFloat.random(in: 0...(view.bounds.height-60))
            label.frame = CGRect(x: x, y: y, width: 60, height: 60)
            view.addSubview(label)
        }
    }
    
    private func CluckQuestChickenSetupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 16
        let itemWidth = (view.bounds.width - 48) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 160)
        CluckQuestChickenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CluckQuestChickenCollectionView.backgroundColor = .clear
        CluckQuestChickenCollectionView.delegate = self
        CluckQuestChickenCollectionView.dataSource = self
        CluckQuestChickenCollectionView.register(CluckQuestChickenGameCell.self, forCellWithReuseIdentifier: "CluckQuestChickenGameCell")
        CluckQuestChickenCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenCollectionView)
        NSLayoutConstraint.activate([
            CluckQuestChickenCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CluckQuestChickenCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CluckQuestChickenCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            CluckQuestChickenCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CluckQuestChickenViewModel.CluckQuestChickenGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CluckQuestChickenGameCell", for: indexPath) as! CluckQuestChickenGameCell
        let game = CluckQuestChickenViewModel.CluckQuestChickenGames[indexPath.item]
        cell.configure(with: game)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        switch indexPath.item {
        case 0:
            let instructionVC = CluckQuestPuzzleInstructionViewController()
            let nav = UINavigationController(rootViewController: instructionVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case 1:
            let instructionVC = CluckQuestChickenTicTacToeInstructionViewController()
            let nav = UINavigationController(rootViewController: instructionVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case 2:
            let instructionVC = CluckQuestChickenMemoryMatchInstructionViewController()
            let nav = UINavigationController(rootViewController: instructionVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case 3:
            startFarmSweeper()
        default:
            break
        }
    }
    
    @objc private func startFarmSweeper() {
        let instructionVC = CluckQuestChickenFarmSweeperInstructionViewController()
        let nav = UINavigationController(rootViewController: instructionVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

class CluckQuestChickenGameCell: UICollectionViewCell {
    private let CluckQuestChickenEmojiLabel = UILabel()
    private let CluckQuestChickenTitleLabel = UILabel()
    private let CluckQuestChickenSubtitleLabel = UILabel()
    private let CluckQuestChickenCardView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CluckQuestChickenSetupUI()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with game: CluckQuestChickenGameMenuItem) {
        CluckQuestChickenEmojiLabel.text = game.CluckQuestChickenEmoji
        CluckQuestChickenTitleLabel.text = game.CluckQuestChickenTitle
        CluckQuestChickenSubtitleLabel.text = game.CluckQuestChickenSubtitle
    }
    
    private func CluckQuestChickenSetupUI() {
        CluckQuestChickenCardView.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.85)
        CluckQuestChickenCardView.layer.cornerRadius = 16
        CluckQuestChickenCardView.layer.shadowColor = UIColor.black.cgColor
        CluckQuestChickenCardView.layer.shadowOpacity = 0.1
        CluckQuestChickenCardView.layer.shadowRadius = 6
        CluckQuestChickenCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        CluckQuestChickenCardView.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
        CluckQuestChickenCardView.layer.borderWidth = 2
        contentView.addSubview(CluckQuestChickenCardView)
        CluckQuestChickenCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CluckQuestChickenCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            CluckQuestChickenCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CluckQuestChickenCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            CluckQuestChickenCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenEmojiLabel, CluckQuestChickenTitleLabel, CluckQuestChickenSubtitleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenCardView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: CluckQuestChickenCardView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: CluckQuestChickenCardView.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: CluckQuestChickenCardView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: CluckQuestChickenCardView.trailingAnchor, constant: -8)
        ])
        CluckQuestChickenEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenSubtitleLabel.font = UIFont.systemFont(ofSize: 15)
        CluckQuestChickenSubtitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.withAlphaComponent(0.7)
    }
} 
