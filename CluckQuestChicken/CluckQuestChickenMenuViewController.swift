import UIKit

class CluckQuestChickenMenuViewController: UIViewController {
    private let stack = UIStackView()
    private let dataManager = CluckQuestChickenDataManager.shared
    private var chestTimerLabel = UILabel()
    private var chestTimer: Timer?
    private let chestCooldown: TimeInterval = 24*60*60
    private let chestKey = "CluckQuestChickenLastChestOpen"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Menu"
        setupUI()
        updateChestTimer()
    }

    private func setupUI() {
        stack.axis = .vertical
        stack.spacing = 28
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])

        let statsCard = CluckQuestChickenMenuCardView(title: "Statistics", emoji: "📊", color: CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove) { [weak self] in self?.showStats() }
        stack.addArrangedSubview(statsCard)

        let quizCard = CluckQuestChickenMenuCardView(title: "Farm Quiz", emoji: "🐔❓", color: CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture) { [weak self] in self?.showQuiz() }
        stack.addArrangedSubview(quizCard)

        let welcomeCard = CluckQuestChickenMenuCardView(title: "Welcome & Thanks", emoji: "🌱🥚", color: CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove) { [weak self] in self?.showWelcome() }
        stack.addArrangedSubview(welcomeCard)

        let chestCard = CluckQuestChickenMenuCardView(title: "Daily Chest", emoji: "🪙🎁", color: CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture) { [weak self] in self?.showChest() }
        chestTimerLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        chestTimerLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        chestTimerLabel.textAlignment = .center
        chestTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        if let vstack = chestCard.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
            vstack.addArrangedSubview(chestTimerLabel)
        }
        stack.addArrangedSubview(chestCard)
    }
}

class CluckQuestChickenMenuCardView: UIView {
    let tapAction: (() -> Void)
    init(title: String, emoji: String, color: UIColor, tapAction: @escaping () -> Void) {
        self.tapAction = tapAction
        super.init(frame: .zero)
        backgroundColor = color.withAlphaComponent(0.95)
        layer.cornerRadius = 22
        layer.borderWidth = 2
        layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: title == "Daily Chest" ? 130 : 90).isActive = true
        widthAnchor.constraint(equalToConstant: 280).isActive = true
        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 36)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        let vstack = UIStackView(arrangedSubviews: [emojiLabel, titleLabel])
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

extension CluckQuestChickenMenuViewController {
    @objc private func showStats() {
        let vc = CluckQuestChickenStatsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func showQuiz() {
        let vc = CluckQuestChickenQuizViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func showWelcome() {
        let vc = CluckQuestChickenWelcomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func showChest() {
        let now = Date().timeIntervalSince1970
        let last = UserDefaults.standard.double(forKey: chestKey)
        if now - last >= chestCooldown {
            let vc = CluckQuestChickenDailyChestViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Chest Locked", message: "You can open the next chest in \(formatTime(chestCooldown - (now - last))).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    private func updateChestTimer() {
        chestTimer?.invalidate()
        chestTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.refreshChestTimer()
        }
        refreshChestTimer()
    }
    private func refreshChestTimer() {
        let now = Date().timeIntervalSince1970
        let last = UserDefaults.standard.double(forKey: chestKey)
        let remain = chestCooldown - (now - last)
        if remain <= 0 {
            chestTimerLabel.text = "Open now!"
        } else {
            chestTimerLabel.text = "Next chest: \(formatTime(remain))"
        }
    }
    private func formatTime(_ interval: TimeInterval) -> String {
        let ti = Int(interval)
        let h = ti / 3600
        let m = (ti % 3600) / 60
        let s = ti % 60
        return String(format: "%02dh %02dm %02ds", h, m, s)
    }
} 
