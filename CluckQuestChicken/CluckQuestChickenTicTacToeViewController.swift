import UIKit

class CluckQuestChickenTicTacToeViewController: UIViewController {
    private let CluckQuestChickenViewModel = CluckQuestChickenTicTacToeViewModel()
    private let CluckQuestChickenGridButtons: [UIButton] = (0..<9).map { _ in UIButton(type: .system) }
    private let CluckQuestChickenTimerLabel = UILabel()
    private let CluckQuestChickenHUD = UIView()
    var CluckQuestSelectedDifficulty: String = "Easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Tic-Tac-Toe"
        CluckQuestChickenSetupHUD()
        CluckQuestChickenSetupGrid()
        CluckQuestChickenStartGame()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(CluckQuestChickenBackTapped))
    }
    
    private func CluckQuestChickenSetupHUD() {
        CluckQuestChickenHUD.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.7)
        CluckQuestChickenHUD.layer.cornerRadius = 16
        CluckQuestChickenHUD.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenHUD)
        CluckQuestChickenTimerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenTimerLabel.textColor = UIColor(red: 1, green: 0.95, blue: 0.69, alpha: 1)
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenTimerLabel])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenHUD.addSubview(stack)
        NSLayoutConstraint.activate([
            CluckQuestChickenHUD.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            CluckQuestChickenHUD.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenHUD.heightAnchor.constraint(equalToConstant: 48),
            CluckQuestChickenHUD.widthAnchor.constraint(equalToConstant: 160),
            stack.centerXAnchor.constraint(equalTo: CluckQuestChickenHUD.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: CluckQuestChickenHUD.centerYAnchor)
        ])
    }
    
    private func CluckQuestChickenSetupGrid() {
        let grid = UIStackView()
        grid.axis = .vertical
        grid.spacing = 8
        grid.translatesAutoresizingMaskIntoConstraints = false
        for row in 0..<3 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            for col in 0..<3 {
                let idx = row*3+col
                let btn = CluckQuestChickenGridButtons[idx]
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
                btn.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText, for: .normal)
                btn.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.85)
                btn.layer.cornerRadius = 16
                btn.layer.borderWidth = 2
                btn.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
                btn.layer.shadowColor = UIColor.black.cgColor
                btn.layer.shadowOpacity = 0.1
                btn.layer.shadowRadius = 6
                btn.layer.shadowOffset = CGSize(width: 0, height: 2)
                btn.tag = idx
                btn.addTarget(self, action: #selector(CluckQuestChickenCellTapped(_:)), for: .touchUpInside)
                rowStack.addArrangedSubview(btn)
                btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
                btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
            }
            grid.addArrangedSubview(rowStack)
        }
        view.addSubview(grid)
        NSLayoutConstraint.activate([
            grid.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grid.topAnchor.constraint(equalTo: CluckQuestChickenHUD.bottomAnchor, constant: 32)
        ])
    }
    
    private func CluckQuestChickenStartGame() {
        CluckQuestChickenViewModel.CluckQuestChickenDifficulty = CluckQuestSelectedDifficulty
        CluckQuestChickenViewModel.CluckQuestChickenStartGame()
        CluckQuestChickenViewModel.CluckQuestChickenOnUpdate = { [weak self] in
            self?.CluckQuestChickenUpdateUI()
        }
        CluckQuestChickenViewModel.CluckQuestChickenOnComplete = { [weak self] result in
            self?.CluckQuestChickenShowCompletion(result: result)
        }
        CluckQuestChickenUpdateUI()
    }
    
    private func CluckQuestChickenUpdateUI() {
        for (i, btn) in CluckQuestChickenGridButtons.enumerated() {
            btn.setTitle(CluckQuestChickenViewModel.CluckQuestChickenBoard[i].rawValue, for: .normal)
            btn.isEnabled = CluckQuestChickenViewModel.CluckQuestChickenBoard[i] == .empty && CluckQuestChickenViewModel.CluckQuestChickenCurrentTurn == .player
        }
        let min = CluckQuestChickenViewModel.CluckQuestChickenElapsed / 60
        let sec = CluckQuestChickenViewModel.CluckQuestChickenElapsed % 60
        CluckQuestChickenTimerLabel.text = String(format: "%02d:%02d", min, sec)
    }
    
    @objc private func CluckQuestChickenCellTapped(_ sender: UIButton) {
        let idx = sender.tag
        CluckQuestChickenViewModel.CluckQuestChickenMakeMove(at: idx)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc private func CluckQuestChickenBackTapped() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    private func CluckQuestChickenShowCompletion(result: CluckQuestChickenTicTacToeResult) {
        let (xp, coins) = CluckQuestChickenViewModel.CluckQuestChickenXPAndCoins(result: result)
        let vc = CluckQuestChickenTicTacToeCompletionViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.CluckQuestChickenResult = result
        vc.CluckQuestChickenTime = CluckQuestChickenViewModel.CluckQuestChickenElapsed
        vc.CluckQuestChickenXP = xp
        vc.CluckQuestChickenCoins = coins
        present(vc, animated: true)
    }
} 