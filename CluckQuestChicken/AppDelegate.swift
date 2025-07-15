import UIKit

@main
class CluckQuestChickenAppDelegate: UIResponder, UIApplicationDelegate {

    var CluckQuestChickenWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CluckQuestChickenDesignSystem.CluckQuestChickenInitialize()
        
        CluckQuestChickenWindow = UIWindow(frame: UIScreen.main.bounds)
        let CluckQuestChickenSplashVC = CluckQuestChickenSplashViewController()
        CluckQuestChickenWindow?.rootViewController = CluckQuestChickenSplashVC
        CluckQuestChickenWindow?.makeKeyAndVisible()
        
        return true
    }
}


