import UIKit

class CluckQuestChickenAchievementsViewController: UIViewController {
    
    private let CluckQuestChickenTableView = UITableView()
    private let dataManager = CluckQuestChickenDataManager.shared
    private var CluckQuestChickenAchievements: [CluckQuestChickenAchievement] = []
    private var CluckQuestChickenPlayerData: CluckQuestChickenPlayerData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CluckQuestChickenSetupUI()
        CluckQuestChickenLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CluckQuestChickenLoadData()
        CluckQuestChickenTableView.reloadData()
    }
    
    private func CluckQuestChickenSetupUI() {
        title = "Achievements"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        CluckQuestChickenTableView.backgroundColor = .clear
        CluckQuestChickenTableView.separatorStyle = .none
        CluckQuestChickenTableView.delegate = self
        CluckQuestChickenTableView.dataSource = self
        CluckQuestChickenTableView.register(CluckQuestChickenAchievementCell.self, forCellReuseIdentifier: "CluckQuestChickenAchievementCell")
        CluckQuestChickenTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenTableView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CluckQuestChickenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CluckQuestChickenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            CluckQuestChickenTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func CluckQuestChickenLoadData() {
        CluckQuestChickenAchievements = dataManager.CluckQuestChickenLoadAchievements()
        CluckQuestChickenPlayerData = dataManager.CluckQuestChickenLoadPlayerData()
        CluckQuestChickenCheckAchievements()
    }
    
    private func CluckQuestChickenCheckAchievements() {
        var CluckQuestChickenUpdatedAchievements = CluckQuestChickenAchievements
        
        for CluckQuestChickenIndex in 0..<CluckQuestChickenUpdatedAchievements.count {
            let CluckQuestChickenAchievement = CluckQuestChickenUpdatedAchievements[CluckQuestChickenIndex]
            
            if !CluckQuestChickenAchievement.CluckQuestChickenAchievementUnlocked {
                let CluckQuestChickenShouldUnlock = CluckQuestChickenCheckAchievementRequirement(CluckQuestChickenAchievement)
                
                if CluckQuestChickenShouldUnlock {
                    CluckQuestChickenUpdatedAchievements[CluckQuestChickenIndex].CluckQuestChickenAchievementUnlocked = true
                    CluckQuestChickenShowAchievementUnlocked(CluckQuestChickenAchievement)
                }
            }
        }
        
        CluckQuestChickenAchievements = CluckQuestChickenUpdatedAchievements
        dataManager.CluckQuestChickenSaveAchievements(CluckQuestChickenAchievements)
    }
    
    private func CluckQuestChickenCheckAchievementRequirement(_ CluckQuestChickenAchievement: CluckQuestChickenAchievement) -> Bool {
        switch CluckQuestChickenAchievement.CluckQuestChickenAchievementID {
        case "first_quest":
            return CluckQuestChickenPlayerData.CluckQuestChickenCompletedQuests.count >= 1
        case "coin_collector":
            return CluckQuestChickenPlayerData.CluckQuestChickenCluckCoins >= 1000
        default:
            return false
        }
    }
    
    private func CluckQuestChickenShowAchievementUnlocked(_ CluckQuestChickenAchievement: CluckQuestChickenAchievement) {
        let CluckQuestChickenAlert = UIAlertController(
            title: "🏆 Achievement Unlocked!",
            message: "\(CluckQuestChickenAchievement.CluckQuestChickenAchievementEmoji) \(CluckQuestChickenAchievement.CluckQuestChickenAchievementTitle)\n\n\(CluckQuestChickenAchievement.CluckQuestChickenAchievementDescription)\n\n\(CluckQuestChickenGetCoopBotQuip())",
            preferredStyle: .alert
        )
        
        CluckQuestChickenAlert.addAction(UIAlertAction(title: "Awesome!", style: .default))
        present(CluckQuestChickenAlert, animated: true)
    }
    
    private func CluckQuestChickenGetCoopBotQuip() -> String {
        let CluckQuestChickenQuips = [
            "CluckBot: Cluck-a-doodle-doo! You're amazing! 🐔",
            "CluckBot: That's egg-cellent work! 🥚",
            "CluckBot: You're really pecking away at those goals! 🐛",
            "CluckBot: Cluck yeah! Keep it up! 🎉"
        ]
        return CluckQuestChickenQuips.randomElement() ?? "CluckBot: Great job! 🐔"
    }
}

extension CluckQuestChickenAchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CluckQuestChickenAchievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CluckQuestChickenCell = tableView.dequeueReusableCell(withIdentifier: "CluckQuestChickenAchievementCell", for: indexPath) as! CluckQuestChickenAchievementCell
        let CluckQuestChickenAchievement = CluckQuestChickenAchievements[indexPath.row]
        CluckQuestChickenCell.CluckQuestChickenConfigure(with: CluckQuestChickenAchievement)
        return CluckQuestChickenCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

class CluckQuestChickenAchievementCell: UITableViewCell {
    private let CluckQuestChickenCardView = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
    private let CluckQuestChickenEmojiLabel = UILabel()
    private let CluckQuestChickenTitleLabel = UILabel()
    private let CluckQuestChickenDescriptionLabel = UILabel()
    private let CluckQuestChickenStatusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        CluckQuestChickenSetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func CluckQuestChickenSetupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        CluckQuestChickenEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        CluckQuestChickenEmojiLabel.textAlignment = .center
        CluckQuestChickenEmojiLabel.setContentHuggingPriority(.required, for: .horizontal)
        CluckQuestChickenEmojiLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenTitleLabel.numberOfLines = 0
        CluckQuestChickenTitleLabel.lineBreakMode = .byWordWrapping
        
        CluckQuestChickenDescriptionLabel.font = UIFont.systemFont(ofSize: 15)
        CluckQuestChickenDescriptionLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText.withAlphaComponent(0.7)
        CluckQuestChickenDescriptionLabel.numberOfLines = 0
        CluckQuestChickenDescriptionLabel.lineBreakMode = .byWordWrapping
        
        CluckQuestChickenStatusLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        CluckQuestChickenStatusLabel.textAlignment = .right
        CluckQuestChickenStatusLabel.setContentHuggingPriority(.required, for: .horizontal)
        CluckQuestChickenStatusLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let CluckQuestChickenTextStackView = UIStackView(arrangedSubviews: [
            CluckQuestChickenTitleLabel,
            CluckQuestChickenDescriptionLabel
        ])
        CluckQuestChickenTextStackView.axis = .vertical
        CluckQuestChickenTextStackView.spacing = 4
        CluckQuestChickenTextStackView.alignment = .fill
        CluckQuestChickenTextStackView.distribution = .fill
        
        let CluckQuestChickenMainStackView = UIStackView(arrangedSubviews: [
            CluckQuestChickenEmojiLabel,
            CluckQuestChickenTextStackView,
            CluckQuestChickenStatusLabel
        ])
        CluckQuestChickenMainStackView.axis = .horizontal
        CluckQuestChickenMainStackView.spacing = 16
        CluckQuestChickenMainStackView.alignment = .center
        CluckQuestChickenMainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCardView.addSubview(CluckQuestChickenMainStackView)
        contentView.addSubview(CluckQuestChickenCardView)
        CluckQuestChickenCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CluckQuestChickenCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            CluckQuestChickenCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            CluckQuestChickenCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            CluckQuestChickenCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            CluckQuestChickenMainStackView.topAnchor.constraint(equalTo: CluckQuestChickenCardView.topAnchor, constant: 16),
            CluckQuestChickenMainStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenCardView.leadingAnchor, constant: 16),
            CluckQuestChickenMainStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenCardView.trailingAnchor, constant: -16),
            CluckQuestChickenMainStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenCardView.bottomAnchor, constant: -16),
            
            CluckQuestChickenEmojiLabel.widthAnchor.constraint(equalToConstant: 60),
            CluckQuestChickenStatusLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func CluckQuestChickenConfigure(with CluckQuestChickenAchievement: CluckQuestChickenAchievement) {
        CluckQuestChickenEmojiLabel.text = CluckQuestChickenAchievement.CluckQuestChickenAchievementEmoji
        CluckQuestChickenTitleLabel.text = CluckQuestChickenAchievement.CluckQuestChickenAchievementTitle
        CluckQuestChickenDescriptionLabel.text = CluckQuestChickenAchievement.CluckQuestChickenAchievementDescription
        
        if CluckQuestChickenAchievement.CluckQuestChickenAchievementUnlocked {
            CluckQuestChickenStatusLabel.text = "✅ Unlocked"
            CluckQuestChickenStatusLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
            CluckQuestChickenCardView.alpha = 1.0
        } else {
            CluckQuestChickenStatusLabel.text = "🔒 Locked"
            CluckQuestChickenStatusLabel.textColor = .gray
            CluckQuestChickenCardView.alpha = 0.6
        }
    }
} 
