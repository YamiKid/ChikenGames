import UIKit

struct CluckQuestChickenDesignSystem {
    static let CluckQuestChickenMintPasture = UIColor(red: 230/255, green: 249/255, blue: 240/255, alpha: 1.0)
    static let CluckQuestChickenSageMeadow = UIColor(red: 200/255, green: 230/255, blue: 201/255, alpha: 1.0)
    static let CluckQuestChickenPistachioGrove = UIColor(red: 168/255, green: 213/255, blue: 186/255, alpha: 1.0)
    static let CluckQuestChickenMossAccent = UIColor(red: 139/255, green: 195/255, blue: 74/255, alpha: 1.0)
    static let CluckQuestChickenBarnwoodText = UIColor(red: 91/255, green: 110/255, blue: 35/255, alpha: 1.0)
    
    static func CluckQuestChickenInitialize() {
        let CluckQuestChickenAppearance = UINavigationBarAppearance()
        CluckQuestChickenAppearance.configureWithOpaqueBackground()
        CluckQuestChickenAppearance.backgroundColor = CluckQuestChickenMintPasture
        CluckQuestChickenAppearance.titleTextAttributes = [
            .foregroundColor: CluckQuestChickenBarnwoodText,
            .font: UIFont.systemFont(ofSize: 26, weight: .semibold)
        ]
        
        UINavigationBar.appearance().standardAppearance = CluckQuestChickenAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = CluckQuestChickenAppearance
        
        let CluckQuestChickenTabBarAppearance = UITabBarAppearance()
        CluckQuestChickenTabBarAppearance.configureWithOpaqueBackground()
        CluckQuestChickenTabBarAppearance.backgroundColor = CluckQuestChickenSageMeadow
        CluckQuestChickenTabBarAppearance.stackedLayoutAppearance.selected.iconColor = CluckQuestChickenMossAccent
        CluckQuestChickenTabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: CluckQuestChickenMossAccent
        ]
        CluckQuestChickenTabBarAppearance.stackedLayoutAppearance.normal.iconColor = CluckQuestChickenBarnwoodText
        CluckQuestChickenTabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: CluckQuestChickenBarnwoodText
        ]
        
        UITabBar.appearance().standardAppearance = CluckQuestChickenTabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = CluckQuestChickenTabBarAppearance
    }
    
    static func CluckQuestChickenCreateCardView() -> UIView {
        let CluckQuestChickenCardView = UIView()
        CluckQuestChickenCardView.backgroundColor = CluckQuestChickenPistachioGrove
        CluckQuestChickenCardView.layer.cornerRadius = 16
        CluckQuestChickenCardView.layer.shadowColor = UIColor.black.cgColor
        CluckQuestChickenCardView.layer.shadowOpacity = 0.1
        CluckQuestChickenCardView.layer.shadowRadius = 6
        CluckQuestChickenCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return CluckQuestChickenCardView
    }
    
    static func CluckQuestChickenCreateButton() -> UIButton {
        let CluckQuestChickenButton = UIButton(type: .system)
        CluckQuestChickenButton.backgroundColor = CluckQuestChickenMossAccent
        CluckQuestChickenButton.setTitleColor(.white, for: .normal)
        CluckQuestChickenButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        CluckQuestChickenButton.layer.cornerRadius = 16
        return CluckQuestChickenButton
    }
} 