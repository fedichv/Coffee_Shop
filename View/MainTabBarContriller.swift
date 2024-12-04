import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(RoundedTabBar(), forKey: "tabBar")

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // Центрируем изображение

        let basketVC = UINavigationController(rootViewController: BasketViewController())
        basketVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "basket"), tag: 1)
        basketVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // Центрируем изображение

        viewControllers = [homeVC, basketVC]

        tabBar.tintColor = UIColor(named: "ActiveColor") ?? .systemBrown
        tabBar.unselectedItemTintColor = UIColor(named: "InactiveColor") ?? .lightGray
    }
}
