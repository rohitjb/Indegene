import Foundation
import  UIKit

protocol ContentNavigator {
}

class IndengeContentNavigator: ContentNavigator {
    lazy var navController: UINavigationController = {
        let contentViewController = ContentViewController(navigator: self)
        let navController = UINavigationController(rootViewController: contentViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.orange
        return navController
    }()
}
