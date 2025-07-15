import UIKit
import SafariServices

class CluckQuestChickenSettingsViewController: UIViewController {
    
    private let CluckQuestChickenScrollView = UIScrollView()
    private let CluckQuestChickenContentView = UIView()
    private let dataManager = CluckQuestChickenDataManager.shared
    private var CluckQuestChickenPlayerData: CluckQuestChickenPlayerData!
    
    private let CluckQuestChickenCoopBotSegmentedControl = UISegmentedControl()
    private let CluckQuestChickenStatsLabel = UILabel()
    private let CluckQuestChickenResetButton = CluckQuestChickenDesignSystem.CluckQuestChickenCreateButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CluckQuestChickenSetupUI()
        CluckQuestChickenLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CluckQuestChickenLoadData()
        CluckQuestChickenUpdateUI()
    }
    
    private func CluckQuestChickenSetupUI() {
        title = "Settings"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        view.addSubview(CluckQuestChickenScrollView)
        CluckQuestChickenScrollView.addSubview(CluckQuestChickenContentView)
        
        CluckQuestChickenScrollView.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CluckQuestChickenScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CluckQuestChickenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CluckQuestChickenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            CluckQuestChickenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            CluckQuestChickenContentView.topAnchor.constraint(equalTo: CluckQuestChickenScrollView.topAnchor),
            CluckQuestChickenContentView.leadingAnchor.constraint(equalTo: CluckQuestChickenScrollView.leadingAnchor),
            CluckQuestChickenContentView.trailingAnchor.constraint(equalTo: CluckQuestChickenScrollView.trailingAnchor),
            CluckQuestChickenContentView.bottomAnchor.constraint(equalTo: CluckQuestChickenScrollView.bottomAnchor),
            CluckQuestChickenContentView.widthAnchor.constraint(equalTo: CluckQuestChickenScrollView.widthAnchor)
        ])
        
        CluckQuestChickenSetupSettings()
    }
    
    private func CluckQuestChickenSetupSettings() {
        let CluckQuestChickenCoopBotCard = CluckQuestChickenCreateCoopBotCard()
        let CluckQuestChickenStatsCard = CluckQuestChickenCreateStatsCard()
        let CluckQuestChickenResetCard = CluckQuestChickenCreateResetCard()
        let CluckQuestChickenPrivacyCard = CluckQuestChickenCreatePrivacyCard()
        
        let CluckQuestChickenStackView = UIStackView(arrangedSubviews: [
            CluckQuestChickenCoopBotCard,
            CluckQuestChickenStatsCard,
            CluckQuestChickenResetCard,
            CluckQuestChickenPrivacyCard
        ])
        CluckQuestChickenStackView.axis = .vertical
        CluckQuestChickenStackView.spacing = 20
        CluckQuestChickenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenContentView.addSubview(CluckQuestChickenStackView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenStackView.topAnchor.constraint(equalTo: CluckQuestChickenContentView.topAnchor, constant: 20),
            CluckQuestChickenStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenContentView.leadingAnchor, constant: 20),
            CluckQuestChickenStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenContentView.trailingAnchor, constant: -20),
            CluckQuestChickenStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenContentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func CluckQuestChickenCreateCoopBotCard() -> UIView {
        let CluckQuestChickenCardView = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
        
        let CluckQuestChickenTitleLabel = UILabel()
        CluckQuestChickenTitleLabel.text = "🤖 CoopBot Mode"
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        
        for CluckQuestChickenMode in CluckQuestChickenCoopBotMode.allCases {
            CluckQuestChickenCoopBotSegmentedControl.insertSegment(withTitle: CluckQuestChickenMode.rawValue, at: CluckQuestChickenCoopBotSegmentedControl.numberOfSegments, animated: false)
        }
        CluckQuestChickenCoopBotSegmentedControl.addTarget(self, action: #selector(CluckQuestChickenCoopBotModeChanged), for: .valueChanged)
        CluckQuestChickenCoopBotSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let CluckQuestChickenStackView = UIStackView(arrangedSubviews: [CluckQuestChickenTitleLabel, CluckQuestChickenCoopBotSegmentedControl])
        CluckQuestChickenStackView.axis = .vertical
        CluckQuestChickenStackView.spacing = 12
        CluckQuestChickenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCardView.addSubview(CluckQuestChickenStackView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenStackView.topAnchor.constraint(equalTo: CluckQuestChickenCardView.topAnchor, constant: 16),
            CluckQuestChickenStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenCardView.leadingAnchor, constant: 16),
            CluckQuestChickenStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenCardView.trailingAnchor, constant: -16),
            CluckQuestChickenStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenCardView.bottomAnchor, constant: -16)
        ])
        
        return CluckQuestChickenCardView
    }
    
    private func CluckQuestChickenCreateStatsCard() -> UIView {
        let CluckQuestChickenCardView = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
        
        let CluckQuestChickenTitleLabel = UILabel()
        CluckQuestChickenTitleLabel.text = "📊 Game Statistics"
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        
        CluckQuestChickenStatsLabel.font = UIFont.systemFont(ofSize: 14)
        CluckQuestChickenStatsLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenStatsLabel.numberOfLines = 0
        
        let CluckQuestChickenStackView = UIStackView(arrangedSubviews: [CluckQuestChickenTitleLabel, CluckQuestChickenStatsLabel])
        CluckQuestChickenStackView.axis = .vertical
        CluckQuestChickenStackView.spacing = 12
        CluckQuestChickenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCardView.addSubview(CluckQuestChickenStackView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenStackView.topAnchor.constraint(equalTo: CluckQuestChickenCardView.topAnchor, constant: 16),
            CluckQuestChickenStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenCardView.leadingAnchor, constant: 16),
            CluckQuestChickenStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenCardView.trailingAnchor, constant: -16),
            CluckQuestChickenStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenCardView.bottomAnchor, constant: -16)
        ])
        
        return CluckQuestChickenCardView
    }
    
    private func CluckQuestChickenCreateResetCard() -> UIView {
        let CluckQuestChickenCardView = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
        
        let CluckQuestChickenTitleLabel = UILabel()
        CluckQuestChickenTitleLabel.text = "🔄 Reset Progress"
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        
        CluckQuestChickenResetButton.setTitle("Reset All Data", for: .normal)
        CluckQuestChickenResetButton.backgroundColor = .systemRed
        CluckQuestChickenResetButton.addTarget(self, action: #selector(CluckQuestChickenResetDataTapped), for: .touchUpInside)
        
        let CluckQuestChickenStackView = UIStackView(arrangedSubviews: [CluckQuestChickenTitleLabel, CluckQuestChickenResetButton])
        CluckQuestChickenStackView.axis = .vertical
        CluckQuestChickenStackView.spacing = 12
        CluckQuestChickenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCardView.addSubview(CluckQuestChickenStackView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenStackView.topAnchor.constraint(equalTo: CluckQuestChickenCardView.topAnchor, constant: 16),
            CluckQuestChickenStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenCardView.leadingAnchor, constant: 16),
            CluckQuestChickenStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenCardView.trailingAnchor, constant: -16),
            CluckQuestChickenStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenCardView.bottomAnchor, constant: -16)
        ])
        
        return CluckQuestChickenCardView
    }
    
    private func CluckQuestChickenCreatePrivacyCard() -> UIView {
        let CluckQuestChickenCardView = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
        
        let CluckQuestChickenTitleLabel = UILabel()
        CluckQuestChickenTitleLabel.text = "🔒 Privacy & Legal"
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        
        let CluckQuestChickenPrivacyButton = CluckQuestChickenDesignSystem.CluckQuestChickenCreateButton()
        CluckQuestChickenPrivacyButton.setTitle("Privacy Policy", for: .normal)
        CluckQuestChickenPrivacyButton.addTarget(self, action: #selector(CluckQuestChickenPrivacyPolicyTapped), for: .touchUpInside)
        
        let CluckQuestChickenTermsButton = CluckQuestChickenDesignSystem.CluckQuestChickenCreateButton()
        CluckQuestChickenTermsButton.setTitle("Terms of Service", for: .normal)
        CluckQuestChickenTermsButton.addTarget(self, action: #selector(CluckQuestChickenTermsOfServiceTapped), for: .touchUpInside)
        
        let CluckQuestChickenStackView = UIStackView(arrangedSubviews: [
            CluckQuestChickenTitleLabel,
            CluckQuestChickenPrivacyButton,
            CluckQuestChickenTermsButton
        ])
        CluckQuestChickenStackView.axis = .vertical
        CluckQuestChickenStackView.spacing = 12
        CluckQuestChickenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCardView.addSubview(CluckQuestChickenStackView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenStackView.topAnchor.constraint(equalTo: CluckQuestChickenCardView.topAnchor, constant: 16),
            CluckQuestChickenStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenCardView.leadingAnchor, constant: 16),
            CluckQuestChickenStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenCardView.trailingAnchor, constant: -16),
            CluckQuestChickenStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenCardView.bottomAnchor, constant: -16)
        ])
        
        return CluckQuestChickenCardView
    }
    
    private func CluckQuestChickenLoadData() {
        CluckQuestChickenPlayerData = dataManager.CluckQuestChickenLoadPlayerData()
    }
    
    private func CluckQuestChickenUpdateUI() {
        let CluckQuestChickenModeIndex = CluckQuestChickenCoopBotMode.allCases.firstIndex(of: CluckQuestChickenPlayerData.CluckQuestChickenCoopBotMode) ?? 0
        CluckQuestChickenCoopBotSegmentedControl.selectedSegmentIndex = CluckQuestChickenModeIndex
        
        let CluckQuestChickenCompletedQuests = CluckQuestChickenPlayerData.CluckQuestChickenCompletedQuests.count
        let CluckQuestChickenTotalMiniGames = dataManager.CluckQuestChickenLoadMiniGames().count
        let CluckQuestChickenTotalAreas = dataManager.CluckQuestChickenLoadAreas().count
        let CluckQuestChickenUnlockedAreas = CluckQuestChickenPlayerData.CluckQuestChickenUnlockedAreas.count
        
        CluckQuestChickenStatsLabel.text = """
        Level: \(CluckQuestChickenPlayerData.CluckQuestChickenLevel)
        XP: \(CluckQuestChickenPlayerData.CluckQuestChickenXP)
        CluckCoins: \(CluckQuestChickenPlayerData.CluckQuestChickenCluckCoins)
        Completed Quests: \(CluckQuestChickenCompletedQuests)
        Unlocked Areas: \(CluckQuestChickenUnlockedAreas)/\(CluckQuestChickenTotalAreas)
        Mini-Games Available: \(CluckQuestChickenTotalMiniGames)
        """
    }
    
    @objc private func CluckQuestChickenCoopBotModeChanged() {
        let CluckQuestChickenSelectedMode = CluckQuestChickenCoopBotMode.allCases[CluckQuestChickenCoopBotSegmentedControl.selectedSegmentIndex]
        CluckQuestChickenPlayerData.CluckQuestChickenCoopBotMode = CluckQuestChickenSelectedMode
        dataManager.CluckQuestChickenSavePlayerData(CluckQuestChickenPlayerData)
    }
    
    @objc private func CluckQuestChickenResetDataTapped() {
        let CluckQuestChickenAlert = UIAlertController(
            title: "⚠️ Reset Progress",
            message: "This will permanently delete all your progress, including levels, coins, quests, and achievements. This action cannot be undone.",
            preferredStyle: .alert
        )
        
        CluckQuestChickenAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        CluckQuestChickenAlert.addAction(UIAlertAction(title: "Reset All Data", style: .destructive) { _ in
            self.dataManager.CluckQuestChickenResetAllData()
            self.CluckQuestChickenLoadData()
            self.CluckQuestChickenUpdateUI()
        })
        
        present(CluckQuestChickenAlert, animated: true)
    }
    
    @objc private func CluckQuestChickenPrivacyPolicyTapped() {
        let CluckQuestChickenURL = URL(string: "https://example.com/privacy")!
        let CluckQuestChickenSafariViewController = SFSafariViewController(url: CluckQuestChickenURL)
        present(CluckQuestChickenSafariViewController, animated: true)
    }
    
    @objc private func CluckQuestChickenTermsOfServiceTapped() {
        let CluckQuestChickenURL = URL(string: "https://example.com/terms")!
        let CluckQuestChickenSafariViewController = SFSafariViewController(url: CluckQuestChickenURL)
        present(CluckQuestChickenSafariViewController, animated: true)
    }
} 
