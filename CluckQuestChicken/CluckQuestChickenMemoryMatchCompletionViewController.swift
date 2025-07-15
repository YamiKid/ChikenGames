import UIKit

class CluckQuestChickenMemoryMatchCompletionViewController: UIViewController {
    var CluckQuestChickenTime: Int = 0
    var CluckQuestChickenFlips: Int = 0
    var CluckQuestChickenXP: Int = 0
    var CluckQuestChickenCoins: Int = 0
    private let CluckQuestChickenTimeLabel = UILabel()
    private let CluckQuestChickenFlipsLabel = UILabel()
    private let CluckQuestChickenXPLabel = UILabel()
    private let CluckQuestChickenCoinsLabel = UILabel()
    private let CluckQuestChickenDoneButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.withAlphaComponent(0.96)
        CluckQuestChickenSetupUI()
        let dataManager = CluckQuestChickenDataManager.shared

        if CluckQuestChickenFlips > 0 && CluckQuestChickenTime > 0 {
            dataManager.incrementWin(for: "memory_match")
        } else {
            dataManager.incrementLoss(for: "memory_match")
        }
    }
    
    private func CluckQuestChickenSetupUI() {
        CluckQuestChickenTimeLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        CluckQuestChickenTimeLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenTimeLabel.textAlignment = .center
        CluckQuestChickenTimeLabel.text = "Time: \(CluckQuestChickenTime)s"
        CluckQuestChickenFlipsLabel.font = UIFont.systemFont(ofSize: 20)
        CluckQuestChickenFlipsLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenFlipsLabel.textAlignment = .center
        CluckQuestChickenFlipsLabel.text = "Flips: \(CluckQuestChickenFlips)"
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
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenTimeLabel, CluckQuestChickenFlipsLabel, CluckQuestChickenXPLabel, CluckQuestChickenCoinsLabel, CluckQuestChickenDoneButton])
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
