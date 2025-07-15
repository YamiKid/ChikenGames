import UIKit

class CluckQuestChickenMainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CluckQuestChickenSetupTabs()
    }
    
    private func CluckQuestChickenSetupTabs() {
        let CluckQuestChickenMenuViewController = CluckQuestChickenMenuViewController()
        let CluckQuestChickenMenuNavigationController = UINavigationController(rootViewController: CluckQuestChickenMenuViewController)
        CluckQuestChickenMenuNavigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let CluckQuestChickenAchievementsViewController = CluckQuestChickenAchievementsViewController()
        let CluckQuestChickenAchievementsNavigationController = UINavigationController(rootViewController: CluckQuestChickenAchievementsViewController)
        CluckQuestChickenAchievementsNavigationController.tabBarItem = UITabBarItem(
            title: "Achievements",
            image: UIImage(systemName: "trophy.fill"),
            selectedImage: UIImage(systemName: "trophy.fill")
        )
        
        let CluckQuestChickenFactsViewController = CluckQuestChickenFactsViewController()
        let CluckQuestChickenFactsNavigationController = UINavigationController(rootViewController: CluckQuestChickenFactsViewController)
        CluckQuestChickenFactsNavigationController.tabBarItem = UITabBarItem(
            title: "Facts",
            image: UIImage(systemName: "book.fill"),
            selectedImage: UIImage(systemName: "book.fill")
        )
        
        let CluckQuestChickenSettingsViewController = CluckQuestChickenSettingsViewController()
        let CluckQuestChickenSettingsNavigationController = UINavigationController(rootViewController: CluckQuestChickenSettingsViewController)
        CluckQuestChickenSettingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.fill"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        let CluckQuestChickenGamesViewController = CluckQuestChickenGamesViewController()
        let CluckQuestChickenGamesNavigationController = UINavigationController(rootViewController: CluckQuestChickenGamesViewController)
        CluckQuestChickenGamesNavigationController.tabBarItem = UITabBarItem(
            title: "Games",
            image: UIImage(systemName: "gamecontroller.fill"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        
        viewControllers = [
            CluckQuestChickenMenuNavigationController,
            CluckQuestChickenAchievementsNavigationController,
            CluckQuestChickenFactsNavigationController,
            CluckQuestChickenSettingsNavigationController,
            CluckQuestChickenGamesNavigationController
        ]
    }
} 
