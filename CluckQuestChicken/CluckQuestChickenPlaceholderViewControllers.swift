import UIKit

class CluckQuestChickenGrainCatchViewController: UIViewController {
    var CluckQuestChickenDifficulty: String = "Easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🌾 Grain Catch"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        let CluckQuestChickenLabel = UILabel()
        CluckQuestChickenLabel.text = "🌾 Grain Catch\nComing Soon!\n\nTilt to roll seeds into baskets"
        CluckQuestChickenLabel.numberOfLines = 0
        CluckQuestChickenLabel.textAlignment = .center
        CluckQuestChickenLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        CluckQuestChickenLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenLabel)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            CluckQuestChickenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            CluckQuestChickenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


class CluckQuestChickenFarmViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🗺️ Farm Map"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        let CluckQuestChickenLabel = UILabel()
        CluckQuestChickenLabel.text = "🗺️ Farm Map\nComing Soon!\n\nExplore different farm areas"
        CluckQuestChickenLabel.numberOfLines = 0
        CluckQuestChickenLabel.textAlignment = .center
        CluckQuestChickenLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        CluckQuestChickenLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenLabel)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            CluckQuestChickenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            CluckQuestChickenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

class CluckQuestChickenQuestsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "📋 Quests"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        let CluckQuestChickenLabel = UILabel()
        CluckQuestChickenLabel.text = "📋 Quest Log\nComing Soon!\n\nView and complete farm quests"
        CluckQuestChickenLabel.numberOfLines = 0
        CluckQuestChickenLabel.textAlignment = .center
        CluckQuestChickenLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        CluckQuestChickenLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenLabel)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            CluckQuestChickenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            CluckQuestChickenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

class CluckQuestChickenInventoryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🔧 Tool Shed"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        let CluckQuestChickenLabel = UILabel()
        CluckQuestChickenLabel.text = "🔧 Tool Shed\nComing Soon!\n\nManage your tools and inventory"
        CluckQuestChickenLabel.numberOfLines = 0
        CluckQuestChickenLabel.textAlignment = .center
        CluckQuestChickenLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        CluckQuestChickenLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenLabel)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            CluckQuestChickenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            CluckQuestChickenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

class CluckQuestChickenShopViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🏪 Market Stall"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        let CluckQuestChickenLabel = UILabel()
        CluckQuestChickenLabel.text = "🏪 Market Stall\nComing Soon!\n\nSpend CluckCoins on items"
        CluckQuestChickenLabel.numberOfLines = 0
        CluckQuestChickenLabel.textAlignment = .center
        CluckQuestChickenLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        CluckQuestChickenLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenLabel)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CluckQuestChickenLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            CluckQuestChickenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            CluckQuestChickenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
} 
