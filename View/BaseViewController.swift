import UIKit
enum LastViewedController: String {
    case home
    case basket
}
class BaseViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        safeCurrentController()
        view.backgroundColor = .white
    }
    func safeCurrentController() {
        var controllerIdentifier: LastViewedController?
        switch self {
        case is HomeViewController:
            controllerIdentifier = .home
        case is BasketViewController:
            controllerIdentifier = .basket
        default:
            break
        }
        if let identifier = controllerIdentifier {
            UserDefaults.standard.set(identifier.rawValue, forKey: "LastViewedController")
        }
    }
}
