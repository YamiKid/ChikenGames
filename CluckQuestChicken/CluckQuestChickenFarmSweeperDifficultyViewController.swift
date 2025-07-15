import UIKit

class CluckQuestChickenFarmSweeperDifficultyViewController: UIViewController {
    private let stack = UIStackView()
    private let difficulties: [(title: String, emoji: String, desc: String)] = [
        ("Easy", "🥚", "5x5, 10 mines"),
        ("Medium", "🐥", "7x7, 25 mines"),
        ("Hard", "🐓", "9x9, 35 mines")
    ]
    var onSelect: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Select Difficulty"
        setupUI()
    }

    private func setupUI() {
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        for (idx, diff) in difficulties.enumerated() {
            let card = FarmSweeperDifficultyCardView(title: diff.title, emoji: diff.emoji, desc: diff.desc) { [weak self] in
                self?.selectDifficulty(diff.title)
            }
            card.tag = 100 + idx
            stack.addArrangedSubview(card)
        }
    }

    private func selectDifficulty(_ difficulty: String) {
        let vc = CluckQuestChickenFarmSweeperViewController()
        vc.selectedDifficulty = difficulty
        navigationController?.pushViewController(vc, animated: true)
    }
}

class FarmSweeperDifficultyCardView: UIView {
    let tapAction: (() -> Void)
    init(title: String, emoji: String, desc: String, tapAction: @escaping () -> Void) {
        self.tapAction = tapAction
        super.init(frame: .zero)
        backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.97)
        layer.cornerRadius = 22
        layer.borderWidth = 2
        layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        widthAnchor.constraint(equalToConstant: 280).isActive = true
        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 36)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        let descLabel = UILabel()
        descLabel.text = desc
        descLabel.font = UIFont.systemFont(ofSize: 16)
        descLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.withAlphaComponent(0.7)
        let vstack = UIStackView(arrangedSubviews: [emojiLabel, titleLabel, descLabel])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = 2
        vstack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vstack)
        NSLayoutConstraint.activate([
            vstack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vstack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    required init?(coder: NSCoder) { fatalError() }
    @objc private func cardTapped() {
        animateTap { [weak self] in self?.tapAction() }
    }
    private func animateTap(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.08, animations: { self.alpha = 0.6 }) { _ in
            UIView.animate(withDuration: 0.12, animations: { self.alpha = 1.0 }, completion: { _ in completion() })
        }
    }
} 