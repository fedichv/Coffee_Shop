import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(RoundedTabBar(), forKey: "tabBar")

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)

        let basketVC = UINavigationController(rootViewController: BasketViewController())
        basketVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "basket"), tag: 1)

//        let thirdViewController = UINavigationController(rootViewController: ThirdViewController())
//        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bag"), tag: 2)
//
//        let fourthViewController = UINavigationController(rootViewController: FourthViewController())
//        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag: 3)

        viewControllers = [homeVC, basketVC]//thirdViewController, fourthViewController

        tabBar.tintColor = UIColor(named: "ActiveColor") ?? .systemBrown
        tabBar.unselectedItemTintColor = UIColor(named: "InactiveColor") ?? .lightGray // Цвет неактивных
    }
}
