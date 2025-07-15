import UIKit

class CluckQuestChickenMemoryMatchInstructionViewController: UIViewController {
    private let CluckQuestEmojiBanner = UILabel()
    private let CluckQuestInstructionLabel = UILabel()
    private let CluckQuestStartButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        CluckQuestSetupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(CluckQuestChickenBackTapped))
    }
    
    private func CluckQuestSetupUI() {
        CluckQuestEmojiBanner.text = "🃏🐔🌾🧠"
        CluckQuestEmojiBanner.font = UIFont.systemFont(ofSize: 48)
        CluckQuestEmojiBanner.textAlignment = .center
        CluckQuestEmojiBanner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestEmojiBanner)
        
        CluckQuestInstructionLabel.text = "Find all pairs! Tap cards to flip them. Match all pairs as fast as you can."
        CluckQuestInstructionLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        CluckQuestInstructionLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestInstructionLabel.textAlignment = .center
        CluckQuestInstructionLabel.numberOfLines = 0
        CluckQuestInstructionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestInstructionLabel)
        
        CluckQuestStartButton.setTitle("Start", for: .normal)
        CluckQuestStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        CluckQuestStartButton.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
        CluckQuestStartButton.layer.cornerRadius = 16
        CluckQuestStartButton.layer.borderWidth = 2
        CluckQuestStartButton.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
        CluckQuestStartButton.backgroundColor = .white
        CluckQuestStartButton.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestStartButton.addTarget(self, action: #selector(CluckQuestStartTapped), for: .touchUpInside)
        view.addSubview(CluckQuestStartButton)
        
        NSLayoutConstraint.activate([
            CluckQuestEmojiBanner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            CluckQuestEmojiBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestInstructionLabel.topAnchor.constraint(equalTo: CluckQuestEmojiBanner.bottomAnchor, constant: 40),
            CluckQuestInstructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            CluckQuestInstructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            CluckQuestStartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            CluckQuestStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestStartButton.widthAnchor.constraint(equalToConstant: 200),
            CluckQuestStartButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    @objc private func CluckQuestStartTapped() {
        let vc = CluckQuestChickenMemoryMatchDifficultyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func CluckQuestChickenBackTapped() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
} 