import UIKit

class CluckQuestChickenFarmSweeperCompletionViewController: UIViewController {
    var CluckQuestChickenWin: Bool = false
    var CluckQuestChickenTime: Int = 0
    var CluckQuestChickenXP: Int = 0
    var CluckQuestChickenCoins: Int = 0
    private let CluckQuestChickenResultLabel = UILabel()
    private let CluckQuestChickenTimeLabel = UILabel()
    private let CluckQuestChickenXPLabel = UILabel()
    private let CluckQuestChickenCoinsLabel = UILabel()
    private let CluckQuestChickenDoneButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.withAlphaComponent(0.96)
        CluckQuestChickenSetupUI()
        let dataManager = CluckQuestChickenDataManager.shared
        if CluckQuestChickenWin {
            dataManager.incrementWin(for: "farm_sweeper")
        } else {
            dataManager.incrementLoss(for: "farm_sweeper")
        }
    }
    
    private func CluckQuestChickenSetupUI() {
        CluckQuestChickenResultLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        CluckQuestChickenResultLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenResultLabel.textAlignment = .center
        CluckQuestChickenResultLabel.text = CluckQuestChickenWin ? "Sweep Complete!" : "Game Over"
        CluckQuestChickenTimeLabel.font = UIFont.systemFont(ofSize: 20)
        CluckQuestChickenTimeLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenTimeLabel.textAlignment = .center
        CluckQuestChickenTimeLabel.text = "Time: \(CluckQuestChickenTime)s"
        CluckQuestChickenXPLabel.font = UIFont.systemFont(ofSize: 20)
        CluckQuestChickenXPLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        CluckQuestChickenXPLabel.textAlignment = .center
        CluckQuestChickenXPLabel.text = "+\(CluckQuestChickenXP) XP"
        CluckQuestChickenCoinsLabel.font = UIFont.systemFont(ofSize: 20)
        CluckQuestChickenCoinsLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        CluckQuestChickenCoinsLabel.textAlignment = .center
        CluckQuestChickenCoinsLabel.text = "+\(CluckQuestChickenCoins) CluckCoins"
        CluckQuestChickenDoneButton.setTitle("Back to Games", for: .normal)
        CluckQuestChickenDoneButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenDoneButton.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
        CluckQuestChickenDoneButton.layer.cornerRadius = 16
        CluckQuestChickenDoneButton.layer.borderWidth = 2
        CluckQuestChickenDoneButton.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.cgColor
        CluckQuestChickenDoneButton.backgroundColor = .white
        CluckQuestChickenDoneButton.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenDoneButton.addTarget(self, action: #selector(CluckQuestChickenDoneTapped), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenResultLabel, CluckQuestChickenTimeLabel, CluckQuestChickenXPLabel, CluckQuestChickenCoinsLabel, CluckQuestChickenDoneButton])
        stack.axis = .vertical
        stack.spacing = 18
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            CluckQuestChickenDoneButton.heightAnchor.constraint(equalToConstant: 54),
            CluckQuestChickenDoneButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func CluckQuestChickenDoneTapped() {
        dismiss(animated: true)
        presentingViewController?.dismiss(animated: true)
    }
} 