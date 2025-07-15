import UIKit

class CluckQuestChickenSplashViewController: UIViewController {
    private let CluckQuestChickenViewModel = CluckQuestChickenSplashViewModel()
    private let CluckQuestChickenLoadingLabel = UILabel()
    private let CluckQuestChickenGradientLayer = CAGradientLayer()
    private let CluckQuestChickenCluckyMascot = UILabel()
    private let CluckQuestChickenBorderEmojis: [UILabel] = []
    private let CluckQuestChickenSunbeamLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CluckQuestChickenSetupGradient()
        CluckQuestChickenSetupSunbeam()
        CluckQuestChickenSetupBorderEmojis()
        CluckQuestChickenSetupCluckyMascot()
        CluckQuestChickenSetupLoadingLabel()
        CluckQuestChickenViewModel.CluckQuestChickenOnFinish = { [weak self] in
            self?.CluckQuestChickenFinishSplash()
        }
        CluckQuestChickenViewModel.CluckQuestChickenStartSplash()
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
    
    private func CluckQuestChickenSetupSunbeam() {
        let CluckQuestChickenSunbeam = UIImage(systemName: "sun.max.fill")?.withTintColor(CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove, renderingMode: .alwaysOriginal)
        let CluckQuestChickenSunbeamImageView = UIImageView(image: CluckQuestChickenSunbeam)
        CluckQuestChickenSunbeamImageView.alpha = 0.18
        CluckQuestChickenSunbeamImageView.frame = CGRect(x: view.bounds.midX-90, y: 40, width: 180, height: 180)
        CluckQuestChickenSunbeamImageView.contentMode = .scaleAspectFit
        view.addSubview(CluckQuestChickenSunbeamImageView)
        UIView.animate(withDuration: 2.5, delay: 0, options: [.repeat, .curveLinear], animations: {
            CluckQuestChickenSunbeamImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: nil)
    }
    
    private func CluckQuestChickenSetupBorderEmojis() {
        let CluckQuestChickenBorderEmojiList = ["🌾", "🍃", "🐛", "🍯", "🥚", "🪶", "🌻", "🥕", "🍎", "🐔"]
        let CluckQuestChickenBorderCount = 10
        let width = view.bounds.width
        let height = view.bounds.height
        for i in 0..<CluckQuestChickenBorderCount {
            let top = UILabel()
            top.text = CluckQuestChickenBorderEmojiList[i % CluckQuestChickenBorderEmojiList.count]
            top.font = UIFont.systemFont(ofSize: 28)
            top.frame = CGRect(x: CGFloat(i) * width / CGFloat(CluckQuestChickenBorderCount), y: 8, width: 32, height: 32)
            view.addSubview(top)
            let bottom = UILabel()
            bottom.text = CluckQuestChickenBorderEmojiList[(i+3) % CluckQuestChickenBorderEmojiList.count]
            bottom.font = UIFont.systemFont(ofSize: 28)
            bottom.frame = CGRect(x: CGFloat(i) * width / CGFloat(CluckQuestChickenBorderCount), y: height-40, width: 32, height: 32)
            view.addSubview(bottom)
        }
        for i in 1..<CluckQuestChickenBorderCount-1 {
            let left = UILabel()
            left.text = CluckQuestChickenBorderEmojiList[(i+5) % CluckQuestChickenBorderEmojiList.count]
            left.font = UIFont.systemFont(ofSize: 28)
            left.frame = CGRect(x: 8, y: CGFloat(i) * height / CGFloat(CluckQuestChickenBorderCount), width: 32, height: 32)
            view.addSubview(left)
            let right = UILabel()
            right.text = CluckQuestChickenBorderEmojiList[(i+7) % CluckQuestChickenBorderEmojiList.count]
            right.font = UIFont.systemFont(ofSize: 28)
            right.frame = CGRect(x: width-40, y: CGFloat(i) * height / CGFloat(CluckQuestChickenBorderCount), width: 32, height: 32)
            view.addSubview(right)
        }
    }
    
    private func CluckQuestChickenSetupCluckyMascot() {
        CluckQuestChickenCluckyMascot.text = "🐔"
        CluckQuestChickenCluckyMascot.font = UIFont.systemFont(ofSize: 100)
        CluckQuestChickenCluckyMascot.textAlignment = .center
        CluckQuestChickenCluckyMascot.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenCluckyMascot)
        NSLayoutConstraint.activate([
            CluckQuestChickenCluckyMascot.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenCluckyMascot.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30)
        ])
        CluckQuestChickenAnimateCluckyMascot()
    }
    
    private func CluckQuestChickenAnimateCluckyMascot() {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.CluckQuestChickenCluckyMascot.transform = CGAffineTransform(scaleX: 1.12, y: 0.88).rotated(by: 0.08)
        }, completion: nil)
    }
    
    private func CluckQuestChickenSetupLoadingLabel() {
        CluckQuestChickenLoadingLabel.text = "Loading"
        CluckQuestChickenLoadingLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        CluckQuestChickenLoadingLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenLoadingLabel.textAlignment = .center
        CluckQuestChickenLoadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestChickenLoadingLabel)
        NSLayoutConstraint.activate([
            CluckQuestChickenLoadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenLoadingLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36)
        ])
        CluckQuestChickenAnimateLoadingLabel()
    }
    
    private func CluckQuestChickenAnimateLoadingLabel() {
        let colors: [UIColor] = [
            CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText,
            CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent,
            CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove
        ]
        var colorIndex = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self else { timer.invalidate(); return }
            UIView.transition(with: self.CluckQuestChickenLoadingLabel, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.CluckQuestChickenLoadingLabel.textColor = colors[colorIndex % colors.count]
                self.CluckQuestChickenLoadingLabel.transform = CGAffineTransform(translationX: CGFloat(sin(Double(colorIndex))*8), y: 0)
            }, completion: nil)
            colorIndex += 1
        }
    }
    
    private func CluckQuestChickenFinishSplash() {
        if !UserDefaults.standard.bool(forKey: "CluckQuestChickenHasOnboarded") {
            let onboarding = CluckQuestChickenOnboardingViewController()
            onboarding.modalPresentationStyle = .fullScreen
            self.present(onboarding, animated: true, completion: nil)
        } else {
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            window?.rootViewController = CluckQuestChickenMainTabBarController()
        }
    }
} 