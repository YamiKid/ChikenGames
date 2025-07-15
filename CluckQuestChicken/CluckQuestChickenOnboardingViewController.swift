import UIKit

class CluckQuestChickenOnboardingViewController: UIViewController {
    private let CluckQuestChickenViewModel = CluckQuestChickenOnboardingViewModel()
    private let CluckQuestChickenGradientLayer = CAGradientLayer()
    private let CluckQuestChickenEmojiBackgroundView = UIView()
    private let CluckQuestChickenTitleLabel = UILabel()
    private let CluckQuestChickenBodyLabel = UILabel()
    private let CluckQuestChickenEmojiLabel = UILabel()
    private let CluckQuestChickenNextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CluckQuestChickenSetupGradient()
        CluckQuestChickenSetupEmojiBackground()
        CluckQuestChickenSetupContent()
        CluckQuestChickenSetupButton()
        CluckQuestChickenShowPage()
        CluckQuestChickenViewModel.CluckQuestChickenOnFinish = { [weak self] in
            self?.CluckQuestChickenFinishOnboarding()
        }
    }
    
    private func CluckQuestChickenSetupGradient() {
        CluckQuestChickenGradientLayer.colors = [
            CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture.cgColor,
            CluckQuestChickenDesignSystem.CluckQuestChickenSageMeadow.cgColor
        ]
        CluckQuestChickenGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        CluckQuestChickenGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        CluckQuestChickenGradientLayer.frame = view.bounds
        view.layer.insertSublayer(CluckQuestChickenGradientLayer, at: 0)
    }
    
    private func CluckQuestChickenSetupEmojiBackground() {
        CluckQuestChickenEmojiBackgroundView.frame = view.bounds
        CluckQuestChickenEmojiBackgroundView.isUserInteractionEnabled = false
        view.addSubview(CluckQuestChickenEmojiBackgroundView)
        for _ in 0..<7 {
            let emoji = ["🌱", "🐔", "🍯", "🌾", "🍃"].randomElement()!
            let label = UILabel()
            label.text = emoji
            label.font = UIFont.systemFont(ofSize: CGFloat.random(in: 32...54))
            label.alpha = 0.18
            let x = CGFloat.random(in: 0...(view.bounds.width-60))
            let y = CGFloat.random(in: 0...(view.bounds.height-60))
            label.frame = CGRect(x: x, y: y, width: 60, height: 60)
            CluckQuestChickenEmojiBackgroundView.addSubview(label)
            CluckQuestChickenAnimateEmoji(label)
        }
    }
    
    private func CluckQuestChickenAnimateEmoji(_ label: UILabel) {
        let duration = Double.random(in: 3.0...5.0)
        let dx = CGFloat.random(in: -20...20)
        let dy = CGFloat.random(in: 30...60)
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            label.center = CGPoint(x: label.center.x + dx, y: label.center.y + dy)
        }, completion: nil)
    }
    
    private func CluckQuestChickenSetupContent() {
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenTitleLabel.textAlignment = .center
        CluckQuestChickenTitleLabel.numberOfLines = 2
        CluckQuestChickenTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenTitleLabel)
        
        CluckQuestChickenBodyLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        CluckQuestChickenBodyLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenBodyLabel.textAlignment = .center
        CluckQuestChickenBodyLabel.numberOfLines = 0
        CluckQuestChickenBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenBodyLabel)
        
        CluckQuestChickenEmojiLabel.font = UIFont.systemFont(ofSize: 44)
        CluckQuestChickenEmojiLabel.textAlignment = .center
        CluckQuestChickenEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenEmojiLabel)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            CluckQuestChickenTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            CluckQuestChickenTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            CluckQuestChickenEmojiLabel.topAnchor.constraint(equalTo: CluckQuestChickenTitleLabel.bottomAnchor, constant: 32),
            CluckQuestChickenEmojiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            CluckQuestChickenBodyLabel.topAnchor.constraint(equalTo: CluckQuestChickenEmojiLabel.bottomAnchor, constant: 32),
            CluckQuestChickenBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            CluckQuestChickenBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func CluckQuestChickenSetupButton() {
        CluckQuestChickenNextButton.layer.cornerRadius = 16
        CluckQuestChickenNextButton.layer.borderWidth = 2
        CluckQuestChickenNextButton.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.cgColor
        CluckQuestChickenNextButton.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
        CluckQuestChickenNextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        CluckQuestChickenNextButton.backgroundColor = .clear
        CluckQuestChickenNextButton.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestChickenNextButton.addTarget(self, action: #selector(CluckQuestChickenNextTapped), for: .touchUpInside)
        view.addSubview(CluckQuestChickenNextButton)
        NSLayoutConstraint.activate([
            CluckQuestChickenNextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            CluckQuestChickenNextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenNextButton.widthAnchor.constraint(equalToConstant: 200),
            CluckQuestChickenNextButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func CluckQuestChickenShowPage() {
        let page = CluckQuestChickenViewModel.CluckQuestChickenPages[CluckQuestChickenViewModel.CluckQuestChickenCurrentPage]
        CluckQuestChickenTitleLabel.text = page.CluckQuestChickenTitle
        CluckQuestChickenBodyLabel.text = page.CluckQuestChickenBody
        CluckQuestChickenEmojiLabel.text = page.CluckQuestChickenEmojis
        if CluckQuestChickenViewModel.CluckQuestChickenCurrentPage == CluckQuestChickenViewModel.CluckQuestChickenPages.count - 1 {
            CluckQuestChickenNextButton.setTitle("Let's Cluck!", for: .normal)
        } else {
            CluckQuestChickenNextButton.setTitle("Next", for: .normal)
        }
    }
    
    @objc private func CluckQuestChickenNextTapped() {
        let wasLast = CluckQuestChickenViewModel.CluckQuestChickenCurrentPage == CluckQuestChickenViewModel.CluckQuestChickenPages.count - 1
        CluckQuestChickenViewModel.CluckQuestChickenAdvancePage()
        if !wasLast {
            UIView.transition(with: view, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.CluckQuestChickenShowPage()
            }, completion: nil)
        }
    }
    
    private func CluckQuestChickenFinishOnboarding() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = CluckQuestChickenMainTabBarController()
    }
} 