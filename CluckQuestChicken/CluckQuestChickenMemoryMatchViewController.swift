import UIKit
import SpriteKit

class CluckQuestChickenMemoryMatchViewController: UIViewController, CluckQuestChickenMemoryMatchSceneDelegate {
    var selectedDifficulty: String = "Easy"
    private let viewModel = CluckQuestChickenMemoryMatchViewModel()
    private let skView = SKView()
    private let hud = UIView()
    private let timerLabel = UILabel()
    private let flipsLabel = UILabel()
    private var scene: CluckQuestChickenMemoryMatchScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Memory Match"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        setupHUD()
        setupSKView()
        startGame()
    }
    
    @objc private func backTapped() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    private func setupHUD() {
        hud.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.7)
        hud.layer.cornerRadius = 16
        hud.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hud)
        timerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        timerLabel.textColor = UIColor(red: 1, green: 0.95, blue: 0.69, alpha: 1)
        flipsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        flipsLabel.textColor = UIColor(red: 1, green: 0.95, blue: 0.69, alpha: 1)
        let stack = UIStackView(arrangedSubviews: [timerLabel, flipsLabel])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        hud.addSubview(stack)
        NSLayoutConstraint.activate([
            hud.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            hud.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hud.heightAnchor.constraint(equalToConstant: 48),
            hud.widthAnchor.constraint(equalToConstant: 260),
            stack.centerXAnchor.constraint(equalTo: hud.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: hud.centerYAnchor)
        ])
    }
    
    private func setupSKView() {
        skView.backgroundColor = .clear
        skView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView)
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: hud.bottomAnchor, constant: 16),
            skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func startGame() {
        viewModel.selectedDifficulty = selectedDifficulty
        viewModel.startGame()
        view.layoutIfNeeded()
        let sceneSize = skView.bounds.size
        let grid = viewModel.gridSizes[viewModel.selectedDifficulty] ?? (3, 4)
        scene = CluckQuestChickenMemoryMatchScene(size: sceneSize)
        scene.cards = viewModel.cards
        scene.cols = grid.cols
        scene.rows = grid.rows
        scene.CluckQuestChickenDelegate = self
        skView.presentScene(scene)
        scene.setupCards()
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.updateHUD()
            let oldCards = self.scene.cards
            self.scene.cards = self.viewModel.cards
            self.scene.isBusy = self.viewModel.isBusy
            self.scene.updateAllCardsAnimated(oldCards: oldCards)
        }
        viewModel.onComplete = { [weak self] time, flips in
            self?.showCompletion(time: time, flips: flips)
        }
        updateHUD()
    }
    
    private func updateHUD() {
        let min = viewModel.elapsed / 60
        let sec = viewModel.elapsed % 60
        timerLabel.text = String(format: "%02d:%02d", min, sec)
        flipsLabel.text = "Flips: \(viewModel.flips)"
    }
    
    func CluckQuestChickenMemoryDidFlip(index: Int) {
        viewModel.flipCard(at: index)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func showCompletion(time: Int, flips: Int) {
        let (xp, coins) = viewModel.xpAndCoins()
        let vc = CluckQuestChickenMemoryMatchCompletionViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.CluckQuestChickenTime = time
        vc.CluckQuestChickenFlips = flips
        vc.CluckQuestChickenXP = xp
        vc.CluckQuestChickenCoins = coins
        present(vc, animated: true)
    }
} 