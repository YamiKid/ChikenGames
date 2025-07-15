import UIKit

class CluckQuestChickenStatsViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private let dataManager = CluckQuestChickenDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Statistics"
        setupUI()
        fillData()
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentStack.axis = .vertical
        contentStack.spacing = 32
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48)
        ])

        let coinsCard = statCard(title: "CluckCoins", value: nil, icon: "🪙", detail: nil, color: CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove)
        coinsCard.tag = 1001
        contentStack.addArrangedSubview(coinsCard)

    }

    private func statCard(title: String, value: String?, icon: String, detail: String?, color: UIColor) -> UIView {
        let card = UIView()
        card.backgroundColor = color.withAlphaComponent(0.97)
        card.layer.cornerRadius = 22
        card.layer.borderWidth = 2
        card.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
        card.layer.shadowColor = UIColor.black.withAlphaComponent(0.07).cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowRadius = 8
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 120).isActive = true
        card.widthAnchor.constraint(equalToConstant: 320).isActive = true
        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = UIFont.systemFont(ofSize: 36)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        valueLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        let detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.font = UIFont.systemFont(ofSize: 18)
        detailLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        let vstack = UIStackView(arrangedSubviews: [iconLabel, titleLabel, valueLabel, detailLabel])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = 2
        vstack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(vstack)
        NSLayoutConstraint.activate([
            vstack.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            vstack.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            vstack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            vstack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12)
        ])
        return card
    }

    private func fillData() {
        let player = dataManager.CluckQuestChickenLoadPlayerData()

        if let coinsCard = contentStack.viewWithTag(1001) as? UIView,
           let valueLabel = coinsCard.subviews.compactMap({ $0 as? UIStackView }).first?.arrangedSubviews[2] as? UILabel {
            valueLabel.text = "\(player.CluckQuestChickenCluckCoins)"
        }

        contentStack.arrangedSubviews.filter { $0.tag >= 2000 }.forEach { $0.removeFromSuperview() }

        let games: [(key: String, name: String, icon: String)] = [
            ("memory_match", "Memory Match", "🧠"),
            ("farm_sweeper", "Farm Sweeper", "🌾"),
            ("tic_tac_toe", "Tic Tac Toe", "⭕️❌"),
            ("puzzle_assembly", "Puzzle Assembly", "🧩")
        ]
        for (idx, game) in games.enumerated() {
            let wins = player.CluckQuestChickenWins[game.key] ?? 0
            let losses = player.CluckQuestChickenLosses[game.key] ?? 0
            let draws = player.CluckQuestChickenDraws[game.key] ?? 0
            var detail = "🏆 Wins: \(wins)   ❌ Losses: \(losses)"
            if game.key == "tic_tac_toe" {
                detail += "   🤝 Draws: \(draws)"
            }
            let card = statCard(title: game.name, value: nil, icon: game.icon, detail: detail, color: idx % 2 == 0 ? CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture : CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove)
            card.tag = 2000 + idx
            contentStack.addArrangedSubview(card)
        }
    }
} 
