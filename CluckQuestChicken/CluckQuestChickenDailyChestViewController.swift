import UIKit

class CluckQuestChickenDailyChestViewController: UIViewController {
    private let chestImage = UIImageView()
    private let openButton = UIButton(type: .system)
    private let rewardLabel = UILabel()
    private let dataManager = CluckQuestChickenDataManager.shared
    private let chestKey = "CluckQuestChickenLastChestOpen"
    private let chestCooldown: TimeInterval = 24*60*60
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Daily Chest"
        setupUI()
    }
    private func setupUI() {
        chestImage.image = UIImage(systemName: "shippingbox.fill")
        chestImage.tintColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        chestImage.contentMode = .scaleAspectFit
        chestImage.translatesAutoresizingMaskIntoConstraints = false
        openButton.setTitle("Open Chest", for: .normal)
        openButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        openButton.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
        openButton.backgroundColor = .white
        openButton.layer.cornerRadius = 16
        openButton.layer.borderWidth = 2
        openButton.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.cgColor
        openButton.translatesAutoresizingMaskIntoConstraints = false
        openButton.addTarget(self, action: #selector(openChest), for: .touchUpInside)
        rewardLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        rewardLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        rewardLabel.textAlignment = .center
        rewardLabel.numberOfLines = 0
        rewardLabel.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(arrangedSubviews: [chestImage, openButton, rewardLabel])
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            chestImage.heightAnchor.constraint(equalToConstant: 120),
            chestImage.widthAnchor.constraint(equalToConstant: 120),
            openButton.heightAnchor.constraint(equalToConstant: 54),
            openButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    @objc private func openChest() {
        let now = Date().timeIntervalSince1970
        let last = UserDefaults.standard.double(forKey: chestKey)
        if now - last < chestCooldown {
            let remain = chestCooldown - (now - last)
            let alert = UIAlertController(title: "Chest Locked", message: "You can open the next chest in \(formatTime(remain)).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.chestImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.chestImage.transform = .identity
            }
        }

        let xp = Int.random(in: 30...60)
        let coins = Int.random(in: 20...40)
        dataManager.addXP(xp)
        dataManager.addCoins(coins)
        rewardLabel.text = "+\(xp) XP\n+\(coins) Coins!"
        UserDefaults.standard.set(now, forKey: chestKey)
    }
    private func formatTime(_ interval: TimeInterval) -> String {
        let ti = Int(interval)
        let h = ti / 3600
        let m = (ti % 3600) / 60
        let s = ti % 60
        return String(format: "%02dh %02dm %02ds", h, m, s)
    }
} 
