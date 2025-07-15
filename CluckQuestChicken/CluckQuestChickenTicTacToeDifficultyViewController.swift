import UIKit

class CluckQuestChickenTicTacToeDifficultyViewController: UIViewController {
    private let CluckQuestStack = UIStackView()
    private let CluckQuestDifficulties = [
        (name: "Easy", emoji: "🙂"),
        (name: "Medium", emoji: "😃"),
        (name: "Hard", emoji: "🤓")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Select Difficulty"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(CluckQuestChickenBackTapped))
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
            button.addTarget(self, action: #selector(CluckQuestChickenDifficultyTapped(_:)), for: .touchUpInside)
            let tap = UITapGestureRecognizer(target: self, action: #selector(CluckQuestChickenDifficultyCardTapped(_:)))
            button.addGestureRecognizer(tap)
            let emoji = UILabel()
            emoji.text = diff.emoji
            emoji.font = UIFont.systemFont(ofSize: 36)
            emoji.textAlignment = .center
            emoji.translatesAutoresizingMaskIntoConstraints = false
            let title = UILabel()
            title.text = diff.name
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
    
    @objc private func CluckQuestChickenDifficultyTapped(_ sender: UIButton) {
        let diff = CluckQuestDifficulties[sender.tag].name
        let vc = CluckQuestChickenTicTacToeViewController()
        vc.CluckQuestSelectedDifficulty = diff
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func CluckQuestChickenDifficultyCardTapped(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? UIButton else { return }
        CluckQuestChickenDifficultyTapped(button)
    }
    
    @objc private func CluckQuestChickenBackTapped() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
} 
