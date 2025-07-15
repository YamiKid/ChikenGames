import UIKit

class CluckQuestChickenPuzzleAssemblyCompletionViewController: UIViewController {
    var CluckQuestChickenTime: Int = 0
    var CluckQuestChickenMoves: Int = 0
    var CluckQuestChickenXP: Int = 0
    var CluckQuestChickenCoins: Int = 0
    private let CluckQuestChickenImageView = UIImageView()
    private let CluckQuestChickenTimeLabel = UILabel()
    private let CluckQuestChickenMovesLabel = UILabel()
    private let CluckQuestChickenXPLabel = UILabel()
    private let CluckQuestChickenCoinsLabel = UILabel()
    private let CluckQuestChickenDoneButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.withAlphaComponent(0.96)
        CluckQuestChickenSetupUI()
        let dataManager = CluckQuestChickenDataManager.shared

        if CluckQuestChickenXP > 0 {
            dataManager.incrementWin(for: "puzzle_assembly")
        } else {
            dataManager.incrementLoss(for: "puzzle_assembly")
        }
    }
    
    private func CluckQuestChickenSetupUI() {
        CluckQuestChickenImageView.contentMode = .scaleAspectFit
        CluckQuestChickenImageView.image = UIImage(named: "CluckQuestChickenImg1")
        CluckQuestChickenImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenImageView)
        CluckQuestChickenTimeLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        CluckQuestChickenTimeLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenTimeLabel.textAlignment = .center
        CluckQuestChickenTimeLabel.text = "Time: \(CluckQuestChickenTime)s"
        CluckQuestChickenMovesLabel.font = UIFont.systemFont(ofSize: 20)
        CluckQuestChickenMovesLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenMovesLabel.textAlignment = .center
        CluckQuestChickenMovesLabel.text = "Moves: \(CluckQuestChickenMoves)"
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
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenImageView, CluckQuestChickenTimeLabel, CluckQuestChickenMovesLabel, CluckQuestChickenXPLabel, CluckQuestChickenCoinsLabel, CluckQuestChickenDoneButton])
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
            CluckQuestChickenImageView.heightAnchor.constraint(equalToConstant: 160),
            CluckQuestChickenImageView.widthAnchor.constraint(equalToConstant: 160),
            CluckQuestChickenDoneButton.heightAnchor.constraint(equalToConstant: 54),
            CluckQuestChickenDoneButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func CluckQuestChickenDoneTapped() {
        dismiss(animated: true)
        presentingViewController?.dismiss(animated: true)
    }
} 
