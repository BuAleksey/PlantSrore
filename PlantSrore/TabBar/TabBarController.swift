//
//  TabBarController.swift
//  PlantSrore
//
//  Created by Buba on 15.10.2023.
//

import UIKit

enum TabBarItems {
    case store
    case cart
    case favorites
    
    var tabBarTitle: String {
        switch self {
        case .store:
            "Store"
        case .cart:
            "Cart"
        case .favorites:
            "Favorites"
        }
    }
    
    var tabBarImageName: String {
        switch self {
        case .store:
            "camera.macro.circle"
        case .cart:
            "cart.circle"
        case .favorites:
            "heart"
        }
    }
}

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        generateTabBar()
    }
    
    private func generateTabBar() {
        let items: [TabBarItems] = [.store, .cart, .favorites]
        
        viewControllers = items.map { item in
            switch item {
            case .store:
                //let plantCollection = generateStoreCollection()
                let store = UINavigationController(rootViewController: PlantStoreViewController())
                store.title = item.tabBarTitle
                store.tabBarItem.image = UIImage(systemName: item.tabBarImageName)
                return store
            case .cart:
                let cart = UINavigationController(rootViewController: CartViewController())
                cart.title = item.tabBarTitle
                cart.tabBarItem.image = UIImage(systemName: item.tabBarImageName)
                return cart
            case .favorites:
                let settings = UINavigationController(rootViewController: FavoritesViewController())
                settings.title = item.tabBarTitle
                settings.tabBarItem.image = UIImage(systemName: item.tabBarImageName)
                return settings
            }
        }
    }
    
    private func setTabBarAppearance() {
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .clear
        tabBar.shadowImage = UIImage()
        
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 16
        
        let wight = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: wight,
                height: height
            ),
            cornerRadius: height / 2
        )
        roundLayer.fillColor = UIColor.white.cgColor
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.tintColor = .tabbarGreenItem
        tabBar.unselectedItemTintColor = .tabbarGrayItem
    }
}
