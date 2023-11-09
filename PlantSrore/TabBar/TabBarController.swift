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
            "store"
        case .cart:
            "cart"
        case .favorites:
            "favorites"
        }
    }
}

final class TabBarController: UITabBarController {
    private let items: [TabBarItems] = [.store, .cart, .favorites]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        generateTabBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setDefaultTabBarItemImage()
        setSelectTabBarItemImage(item)
    }
}

// MARK: - Private Metod
extension TabBarController {
    private func generateTabBar() {
        viewControllers = items.map { item in
            switch item {
            case .store:
                let store = UINavigationController(rootViewController: PlantStoreViewController())
                store.title = item.tabBarTitle
                store.tabBarItem.tag = 0
                return store
            case .cart:
                let cart = UINavigationController(rootViewController: CartViewController())
                cart.title = item.tabBarTitle
                cart.tabBarItem.tag = 1
                return cart
            case .favorites:
                let favorites = UINavigationController(rootViewController: FavoritesViewController())
                favorites.title = item.tabBarTitle
                favorites.tabBarItem.tag = 2
                return favorites
            }
        }
        setDefaultTabBarItemImage()
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
    
    private func setSelectTabBarItemImage(_ item: UITabBarItem) {
        switch item.title {
        case "Store":
            guard let viewControllerIndex = viewControllers?.firstIndex(where: {
                $0.title == "Store"
            }) else {
                return
            }
            let image = UIImage.resizeImage(
                UIImage(named: TabBarItems.store.tabBarImageName) ?? UIImage(),
                with: CGSize(width: 150, height: 150)
            )
            viewControllers?[viewControllerIndex].tabBarItem.image = image?.withRenderingMode(
                .alwaysOriginal
            )
            viewControllers?[viewControllerIndex].tabBarItem.titlePositionAdjustment = UIOffset(
                horizontal: 0,
                vertical: 10
            )
        case "Cart":
            guard let viewControllerIndex = viewControllers?.firstIndex(where: {
                $0.title == "Cart"
            }) else {
                return
            }
            let image = UIImage.resizeImage(
                UIImage(named: TabBarItems.cart.tabBarImageName) ?? UIImage(),
                with: CGSize(width: 150, height: 150)
            )
            viewControllers?[viewControllerIndex].tabBarItem.image = image?.withRenderingMode(
                .alwaysOriginal
            )
            viewControllers?[viewControllerIndex].tabBarItem.titlePositionAdjustment = UIOffset(
                horizontal: 0,
                vertical: 10
            )
        case "Favorites":
            guard let viewControllerIndex = viewControllers?.firstIndex(where: {
                $0.title == "Favorites"
            }) else {
                return
            }
            let image = UIImage.resizeImage(
                UIImage(named: TabBarItems.favorites.tabBarImageName) ?? UIImage(),
                with: CGSize(width: 150, height: 150)
            )
            viewControllers?[viewControllerIndex].tabBarItem.image = image?.withRenderingMode(
                .alwaysOriginal
            )
            viewControllers?[viewControllerIndex].tabBarItem.titlePositionAdjustment = UIOffset(
                horizontal: 0,
                vertical: 10
            )
        case .none:
            print("No value")
        case .some(let newValue):
            print("NewValue: \(newValue)")
        }
    }
    
    private func setDefaultTabBarItemImage() {
        viewControllers?.forEach { viewController in
            switch viewController.tabBarItem.tag {
            case 0:
                let image = UIImage.resizeImage(
                    UIImage(named: TabBarItems.store.tabBarImageName) ?? UIImage()
                )
                viewController.tabBarItem.image = image?.withRenderingMode(
                    .alwaysOriginal
                )
                viewController.tabBarItem.titlePositionAdjustment = UIOffset(
                    horizontal: 0,
                    vertical: 0
                )
            case 1:
                let image = UIImage.resizeImage(
                    UIImage(named: TabBarItems.cart.tabBarImageName) ?? UIImage()
                )
                viewController.tabBarItem.image = image?.withRenderingMode(
                    .alwaysOriginal
                )
                viewController.tabBarItem.titlePositionAdjustment = UIOffset(
                    horizontal: 0,
                    vertical: 0
                )
            case 2:
                let image = UIImage.resizeImage(
                    UIImage(named: TabBarItems.favorites.tabBarImageName) ?? UIImage()
                )
                viewController.tabBarItem.image = image?.withRenderingMode(
                    .alwaysOriginal
                )
                viewController.tabBarItem.titlePositionAdjustment = UIOffset(
                    horizontal: 0,
                    vertical: 0
                )
            default:
                print("The case not founded")
            }
        }
    }
}
