import UIKit

class CluckQuestChickenFarmSweeperInstructionViewController: UIViewController {
    private let emojiBanner = UILabel()
    private let instructionLabel = UILabel()
    private let startButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Farm Sweeper"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        setupUI()
    }

    private func setupUI() {
        emojiBanner.text = "🐔💣"
        emojiBanner.font = UIFont.systemFont(ofSize: 64)
        emojiBanner.textAlignment = .center
        emojiBanner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emojiBanner)

        instructionLabel.text = "Open all the tiles without hitting a mine! The more tiles you open, the more XP and coins you earn."
        instructionLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        instructionLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        instructionLabel.textAlignment = .center
        instructionLabel.numberOfLines = 0
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionLabel)

        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        startButton.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 16
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.cgColor
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        view.addSubview(startButton)

        NSLayoutConstraint.activate([
            emojiBanner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            emojiBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: emojiBanner.bottomAnchor, constant: 40),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    @objc private func startTapped() {
        let vc = CluckQuestChickenFarmSweeperDifficultyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func backTapped() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
} 