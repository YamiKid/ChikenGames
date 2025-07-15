import UIKit

class CluckQuestPuzzleDifficultyViewController: UIViewController {
    var CluckQuestSelectedImage: String = "CluckQuestChickenImg1"
    private let CluckQuestDifficulties = [
        (name: "Easy", grid: "3×3", emoji: "🙂"),
        (name: "Medium", grid: "4×4", emoji: "😃"),
        (name: "Hard", grid: "5×5", emoji: "🤓")
    ]
    private let CluckQuestStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Select Difficulty"
        CluckQuestSetupUI()
    }
    
    private func CluckQuestSetupUI() {
        CluckQuestStack.axis = .vertical
        CluckQuestStack.spacing = 32
        CluckQuestStack.alignment = .center
        CluckQuestStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestStack)
        NSLayoutConstraint.activate([
            CluckQuestStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            CluckQuestStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            CluckQuestStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        for (i, diff) in CluckQuestDifficulties.enumerated() {
            let button = UIButton(type: .system)
            button.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.85)
            button.layer.cornerRadius = 20
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.1
            button.layer.shadowRadius = 6
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
            button.layer.borderWidth = 2
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 260).isActive = true
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            button.tag = i
            button.addTarget(self, action: #selector(CluckQuestDifficultyTapped(_:)), for: .touchUpInside)
            let tap = UITapGestureRecognizer(target: self, action: #selector(CluckQuestDifficultyCardTapped(_:)))
            button.addGestureRecognizer(tap)
            let emoji = UILabel()
            emoji.text = diff.emoji
            emoji.font = UIFont.systemFont(ofSize: 36)
            emoji.textAlignment = .center
            emoji.translatesAutoresizingMaskIntoConstraints = false
            let title = UILabel()
            title.text = diff.name + "  " + diff.grid
            title.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            title.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
            title.textAlignment = .center
            title.translatesAutoresizingMaskIntoConstraints = false
            let vstack = UIStackView(arrangedSubviews: [emoji, title])
            vstack.axis = .vertical
            vstack.alignment = .center
            vstack.spacing = 6
            vstack.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(vstack)
            NSLayoutConstraint.activate([
                vstack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                vstack.centerYAnchor.constraint(equalTo: button.centerYAnchor)
            ])
            CluckQuestStack.addArrangedSubview(button)
        }
    }
    
    @objc private func CluckQuestDifficultyTapped(_ sender: UIButton) {
        let diff = CluckQuestDifficulties[sender.tag].name
        let vc = CluckQuestChickenPuzzleAssemblyViewController()
        vc.CluckQuestSelectedImage = CluckQuestSelectedImage
        vc.CluckQuestSelectedDifficulty = diff
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func CluckQuestDifficultyCardTapped(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? UIButton else { return }
        CluckQuestDifficultyTapped(button)
    }
} 
