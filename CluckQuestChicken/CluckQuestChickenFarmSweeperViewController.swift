import UIKit

class CluckQuestChickenFarmSweeperViewController: UIViewController {
    private let CluckQuestChickenViewModel = CluckQuestChickenFarmSweeperViewModel()
    private let CluckQuestChickenHUD = UIView()
    private let CluckQuestChickenTimerLabel = UILabel()
    private let CluckQuestChickenMineLabel = UILabel()
    private let gridStack = UIStackView()
    private var cellButtons: [[UIButton]] = []
    var selectedDifficulty: String = "Easy"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Farm Sweeper"
        setupHUD()
        setupGrid()
        startGame()
    }

    private func setupHUD() {
        CluckQuestChickenHUD.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.7)
        CluckQuestChickenHUD.layer.cornerRadius = 16
        CluckQuestChickenHUD.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenHUD)
        CluckQuestChickenTimerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenTimerLabel.textColor = UIColor(red: 1, green: 0.95, blue: 0.69, alpha: 1)
        CluckQuestChickenMineLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        CluckQuestChickenMineLabel.textColor = UIColor(red: 1, green: 0.95, blue: 0.69, alpha: 1)
        let stack = UIStackView(arrangedSubviews: [CluckQuestChickenTimerLabel, CluckQuestChickenMineLabel])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenHUD.addSubview(stack)
        NSLayoutConstraint.activate([
            CluckQuestChickenHUD.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            CluckQuestChickenHUD.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenHUD.heightAnchor.constraint(equalToConstant: 48),
            CluckQuestChickenHUD.widthAnchor.constraint(equalToConstant: 260),
            stack.centerXAnchor.constraint(equalTo: CluckQuestChickenHUD.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: CluckQuestChickenHUD.centerYAnchor)
        ])
    }

    private func setupGrid() {
        gridStack.axis = .vertical
        gridStack.spacing = 8
        gridStack.alignment = .center
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridStack)
        NSLayoutConstraint.activate([
            gridStack.topAnchor.constraint(equalTo: CluckQuestChickenHUD.bottomAnchor, constant: 24),
            gridStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gridStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gridStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func startGame() {
        CluckQuestChickenViewModel.CluckQuestChickenSelectedDifficulty = selectedDifficulty
        CluckQuestChickenViewModel.CluckQuestChickenStartGame()
        reloadGrid()
        updateHUD()
        CluckQuestChickenViewModel.CluckQuestChickenOnUpdate = { [weak self] in
            self?.reloadGrid()
            self?.updateHUD()
        }
        CluckQuestChickenViewModel.CluckQuestChickenOnComplete = { [weak self] win in
            self?.showCompletion(win: win)
        }
    }

    private func reloadGrid() {

        for row in cellButtons { for btn in row { btn.removeFromSuperview() } }
        cellButtons = []
        gridStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let rows = CluckQuestChickenViewModel.CluckQuestChickenRows
        let cols = CluckQuestChickenViewModel.CluckQuestChickenCols
        let buttonSize: CGFloat = min((view.bounds.width - 32 - CGFloat(cols-1)*8) / CGFloat(cols), 56)
        for r in 0..<rows {
            var rowButtons: [UIButton] = []
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = 8
            hStack.alignment = .center
            hStack.distribution = .fillEqually
            for c in 0..<cols {
                let btn = UIButton(type: .system)
                btn.backgroundColor = UIColor(red: 0.74, green: 0.89, blue: 0.74, alpha: 1)
                btn.layer.cornerRadius = 14
                btn.layer.borderWidth = 2
                btn.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
                btn.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText, for: .normal)
                btn.translatesAutoresizingMaskIntoConstraints = false
                btn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
                btn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
                btn.tag = r * 100 + c
                btn.addTarget(self, action: #selector(cellTapped(_:)), for: .touchUpInside)

                let longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(_:)))
                btn.addGestureRecognizer(longPress)
                rowButtons.append(btn)
                hStack.addArrangedSubview(btn)
            }
            cellButtons.append(rowButtons)
            gridStack.addArrangedSubview(hStack)
        }
        updateCells()
    }

    private func updateCells() {
        let board = CluckQuestChickenViewModel.CluckQuestChickenBoard
        for r in 0..<board.count {
            for c in 0..<board[r].count {
                let cell = board[r][c]
                let btn = cellButtons[r][c]
                if cell.CluckQuestChickenIsRevealed {
                    if cell.CluckQuestChickenIsMine {
                        btn.setTitle("💣", for: .normal)
                        btn.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
                    } else if cell.CluckQuestChickenNeighborMines > 0 {
                        btn.setTitle("\(cell.CluckQuestChickenNeighborMines)", for: .normal)
                        btn.backgroundColor = UIColor.white.withAlphaComponent(0.7)
                    } else {
                        btn.setTitle("", for: .normal)
                        btn.backgroundColor = UIColor.white.withAlphaComponent(0.7)
                    }
                    btn.isEnabled = false
                } else if cell.CluckQuestChickenIsFlagged {
                    btn.setTitle("🚩", for: .normal)
                    btn.backgroundColor = UIColor(red: 0.74, green: 0.89, blue: 0.74, alpha: 1)
                    btn.isEnabled = true
                } else {
                    btn.setTitle("", for: .normal)
                    btn.backgroundColor = UIColor(red: 0.74, green: 0.89, blue: 0.74, alpha: 1)
                    btn.isEnabled = true
                }
            }
        }
    }

    @objc private func cellTapped(_ sender: UIButton) {
        let r = sender.tag / 100
        let c = sender.tag % 100
        CluckQuestChickenViewModel.CluckQuestChickenReveal(r: r, c: c)
    }

    @objc private func cellLongPressed(_ sender: UILongPressGestureRecognizer) {
        guard let btn = sender.view as? UIButton, sender.state == .began else { return }
        let r = btn.tag / 100
        let c = btn.tag % 100
        CluckQuestChickenViewModel.CluckQuestChickenFlag(r: r, c: c)
    }

    private func updateHUD() {
        let min = CluckQuestChickenViewModel.CluckQuestChickenElapsed / 60
        let sec = CluckQuestChickenViewModel.CluckQuestChickenElapsed % 60
        CluckQuestChickenTimerLabel.text = String(format: "%02d:%02d", min, sec)
        CluckQuestChickenMineLabel.text = "Mines: \(CluckQuestChickenViewModel.CluckQuestChickenMines)"
    }

    private func showCompletion(win: Bool) {
        let (xp, coins) = CluckQuestChickenViewModel.CluckQuestChickenXPAndCoins(win: win)
        let vc = CluckQuestChickenFarmSweeperCompletionViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.CluckQuestChickenWin = win
        vc.CluckQuestChickenTime = CluckQuestChickenViewModel.CluckQuestChickenElapsed
        vc.CluckQuestChickenXP = xp
        vc.CluckQuestChickenCoins = coins
        present(vc, animated: true)
    }
} 
