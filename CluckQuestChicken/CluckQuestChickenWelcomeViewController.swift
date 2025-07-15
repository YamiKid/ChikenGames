import UIKit

class CluckQuestChickenWelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Welcome!"
        setupUI()
    }
    private func setupUI() {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -24),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -40),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: -48)
        ])
        let emoji = UILabel()
        emoji.text = "🐔🌱🥚"
        emoji.font = UIFont.systemFont(ofSize: 60)
        emoji.textAlignment = .center
        let title = UILabel()
        title.text = "Welcome to CluckQuestChicken!"
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        title.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        title.textAlignment = .center
        title.numberOfLines = 0
        let thanks = UILabel()
        thanks.text = "Thank you for downloading and playing our game! We hope you enjoy exploring the farm, playing mini-games, and collecting rewards. Your support means a lot to us!\n\nHave fun and good luck, farmer!\n\n— The CluckQuestChicken Team"
        thanks.font = UIFont.systemFont(ofSize: 22)
        thanks.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        thanks.textAlignment = .center
        thanks.numberOfLines = 0
        stack.addArrangedSubview(emoji)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(thanks)
    }
} 